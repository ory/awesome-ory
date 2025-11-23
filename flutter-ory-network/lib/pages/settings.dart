// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/repositories/settings.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/settings/settings_bloc.dart';
import '../repositories/auth.dart';
import '../widgets/helpers.dart';
import 'home.dart';
import 'login.dart';

class SettingsPage extends StatelessWidget {
  final String? flowId;
  const SettingsPage({super.key, this.flowId});

  @override
  Widget build(BuildContext context) {
    final service = RepositoryProvider.of<AuthRepository>(context).service;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 72,
          toolbarHeight: 72,
          // use row to avoid force resizing of leading widget
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 32),
                child: !Navigator.of(context).canPop()
                    ? GestureDetector(
                        onTap: () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomePage())),
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1, color: const Color(0xFFE2E8F0))),
                          child: const Icon(Icons.cancel, size: 16),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  width: 1, color: const Color(0xFFE2E8F0))),
                          child: const Icon(Icons.arrow_back, size: 16),
                        ),
                      ),
              ),
            ],
          )),
      body: BlocProvider(
          create: (context) => SettingsBloc(
              authBloc: context.read<AuthBloc>(),
              repository: SettingsRepository(service: service))
            ..add(flowId != null
                ? GetSettingsFlow(flowId: flowId!)
                : CreateSettingsFlow()),
          child: const SettingsForm()),
    );
  }
}

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: settingsBloc,
            listenWhen: (SettingsState previous, SettingsState current) {
              final wasSessionRefreshRequested =
                  isSessionRefreshRequired(previous.conditions);
              final isSessionRefreshRequested =
                  isSessionRefreshRequired(current.conditions);
              return wasSessionRefreshRequested != isSessionRefreshRequested;
            },
            listener: (BuildContext context, SettingsState state) async {
              // if session needs to be refreshed, navigate to login flow screen
              if (isSessionRefreshRequired(state.conditions)) {
                await Navigator.push(
                    context,
                    MaterialPageRoute<bool?>(
                        builder: (context) => LoginPage(
                              conditions: [SessionRefreshRequested()],
                              aal: 'aal1',
                            ))).then((value) {
                  // retry updating settings when session was refreshed
                  if (value != null) {
                    if (value && state.settingsFlow?.id != null) {
                      settingsBloc.retry();
                    }
                  } else {
                    // if user goes back without finishing login,
                    // reset settings
                    settingsBloc.add(ResetSettings());
                  }
                });
              }
            },
          ),
          // listen to message changes and display them as a snackbar
          BlocListener(
              bloc: settingsBloc,
              listenWhen: (SettingsState previous, SettingsState current) =>
                  // listen to changes only when current
                  // state is not loading (e.g. updating settings),
                  // previous state was loading,
                  // there is a new message,
                  // and session refresh is not required
                  !current.isLoading &&
                  previous.isLoading &&
                  current.settingsFlow?.ui.messages != null &&
                  !isSessionRefreshRequired(current.conditions),
              listener: (BuildContext context, SettingsState state) {
                if (state.settingsFlow!.ui.messages != null) {
                  // for simplicity, we will only show the first message in snackbar
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: getMessageColor(
                        state.settingsFlow!.ui.messages!.first.type),
                    content: Text(state.settingsFlow!.ui.messages!.first.text),
                  ));
                }
              }),

          // when there is a general message,
          // jump to the page start in order to show the message
          BlocListener(
              bloc: settingsBloc,
              listener: (BuildContext context, SettingsState state) {
                if (state.message != null) {
                  // for simplicity,
                  // we will only show the first message in snackbar
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.message!),
                  ));
                }
              }),
          // remove snackbars when loading
          BlocListener(
              bloc: settingsBloc,
              listener: (BuildContext context, SettingsState state) {
                if (state.isLoading) {
                  ScaffoldMessenger.of(context).clearSnackBars();
                }
              })
        ],
        child: BlocBuilder<SettingsBloc, SettingsState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            // settings flow was created
            if (state.settingsFlow != null) {
              return _buildUi(context, state);
            } // otherwise, show loading or error
            else {
              return buildFlowNotCreated(context, state.message);
            }
          },
        ));
  }

  _buildUi(BuildContext context, SettingsState state) {
    final nodes = state.settingsFlow!.ui.nodes;

    // get default nodes from all nodes
    final defaultNodes = nodes.where((node) {
      if (node.group == UiNodeGroupEnum.default_) {
        if (node.attributes.oneOf.isType(UiNodeInputAttributes)) {
          final attributes =
              node.attributes.oneOf.value as UiNodeInputAttributes;
          if (attributes.type == UiNodeInputAttributesTypeEnum.hidden) {
            return false;
          } else {
            return true;
          }
        }
      }
      return false;
    }).toList();

    // get profile nodes from all nodes
    final profileNodes = getNodesOfGroup(UiNodeGroupEnum.profile, nodes);

    // get password nodes from all nodes
    final passwordNodes = getNodesOfGroup(UiNodeGroupEnum.password, nodes);

    // get lookup secret nodes from all nodes
    final lookupSecretNodes =
        getNodesOfGroup(UiNodeGroupEnum.lookupSecret, nodes);

    // get totp nodes from all nodes
    final totpNodes = getNodesOfGroup(UiNodeGroupEnum.totp, nodes);

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          // do not show scrolling indicator
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (defaultNodes.isNotEmpty)
                buildGroup<SettingsBloc>(context, UiNodeGroupEnum.default_,
                    defaultNodes, _onInputChange, _onInputSubmit),
              if (profileNodes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_buildGroupHeadingText(UiNodeGroupEnum.profile),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    buildGroup<SettingsBloc>(context, UiNodeGroupEnum.profile,
                        profileNodes, _onInputChange, _onInputSubmit)
                  ],
                ),
              if (passwordNodes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_buildGroupHeadingText(UiNodeGroupEnum.password),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    buildGroup<SettingsBloc>(context, UiNodeGroupEnum.password,
                        passwordNodes, _onInputChange, _onInputSubmit)
                  ],
                ),
              if (lookupSecretNodes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_buildGroupHeadingText(UiNodeGroupEnum.lookupSecret),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    buildGroup<SettingsBloc>(
                        context,
                        UiNodeGroupEnum.lookupSecret,
                        lookupSecretNodes,
                        _onInputChange,
                        _onInputSubmit)
                  ],
                ),
              if (totpNodes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_buildGroupHeadingText(UiNodeGroupEnum.totp),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            fontSize: 18)),
                    const SizedBox(
                      height: 20,
                    ),
                    buildGroup<SettingsBloc>(context, UiNodeGroupEnum.totp,
                        totpNodes, _onInputChange, _onInputSubmit),
                  ],
                ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
      // build progress indicator when state is loading
      BlocSelector<SettingsBloc, SettingsState, bool>(
          bloc: (context).read<SettingsBloc>(),
          selector: (SettingsState state) => state.isLoading,
          builder: (BuildContext context, bool booleanState) {
            if (booleanState) {
              return const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.white30),
              );
            } else {
              return Container();
            }
          }),
      BlocSelector<SettingsBloc, SettingsState, bool>(
          bloc: (context).read<SettingsBloc>(),
          selector: (SettingsState state) => state.isLoading,
          builder: (BuildContext context, bool booleanState) {
            if (booleanState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          }),
    ]);
  }

  // get group heading
  _buildGroupHeadingText(UiNodeGroupEnum group) {
    switch (group) {
      case UiNodeGroupEnum.lookupSecret:
        return 'Backup Recovery Codes';
      case UiNodeGroupEnum.password:
        return 'Change Password';
      case UiNodeGroupEnum.profile:
        return 'Profile Settings';
      case UiNodeGroupEnum.totp:
        return '2FA Authenticator';
      default:
        return 'Settings';
    }
  }

  _onInputChange(BuildContext context, String value, String name) {
    context
        .read<SettingsBloc>()
        .add(ChangeSettingsNodeValue(value: value, name: name));
  }

  _onInputSubmit(
      BuildContext context, UiNodeGroupEnum group, String name, String value) {
    context.read<SettingsBloc>().add(UpdateSettingsFlow(group: group));
  }
}
