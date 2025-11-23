// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/blocs/bloc/recovery_bloc.dart';
import 'package:ory_network_flutter/repositories/auth.dart';
import 'package:ory_network_flutter/widgets/helpers.dart';

import '../blocs/auth/auth_bloc.dart';

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: GestureDetector(
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
          create: (context) => RecoveryBloc(
              repository: RepositoryProvider.of<AuthRepository>(context))
            ..add(CreateRecoveryFlow()),
          child: const RecoveryForm(),
        ));
  }
}

class RecoveryForm extends StatelessWidget {
  const RecoveryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecoveryBloc, RecoveryState>(
        listener: (context, state) {
          // recovery flow was successful,
          // get session information
          if (state.settingsFlowId != null) {
            final authBloc = (context).read<AuthBloc>();
            authBloc.add(GetCurrentSessionInformation(conditions: [
              RecoveryRequested(settingsFlowId: state.settingsFlowId!)
            ]));
          }
        },
        child: BlocBuilder<RecoveryBloc, RecoveryState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            if (state.recoveryFlow != null) {
              return _buildUi(context, state);
            } else {
              return buildFlowNotCreated(context, state.message);
            }
          },
        ));
  }

  _buildUi(BuildContext context, RecoveryState state) {
    final nodes = state.recoveryFlow!.ui.nodes;

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

    // get code nodes from all nodes
    final codeNodes = nodes.where((node) {
      if (node.group == UiNodeGroupEnum.code) {
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

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          // do not show scrolling indicator
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Text('Recovery',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          fontSize: 18))),
              if (defaultNodes.isNotEmpty)
                buildGroup<RecoveryBloc>(context, UiNodeGroupEnum.default_,
                    defaultNodes, _onInputChange, _onInputSubmit),
              if (codeNodes.isNotEmpty)
                buildGroup<RecoveryBloc>(context, UiNodeGroupEnum.code,
                    codeNodes, _onInputChange, _onInputSubmit),
              const SizedBox(
                height: 32,
              ),
              if (state.recoveryFlow?.ui.messages != null)
                for (var message in state.recoveryFlow!.ui.messages!)
                  Text(
                    message.text,
                    style: TextStyle(color: getMessageColor(message.type)),
                  ),
            ],
          ),
        ),
      ),
      // build progress indicator when state is loading
      BlocSelector<RecoveryBloc, RecoveryState, bool>(
          bloc: (context).read<RecoveryBloc>(),
          selector: (RecoveryState state) => state.isLoading,
          builder: (BuildContext context, bool isLoading) {
            if (isLoading) {
              return const Opacity(
                opacity: 0.8,
                child: ModalBarrier(dismissible: false, color: Colors.white30),
              );
            } else {
              return Container();
            }
          }),
      BlocSelector<RecoveryBloc, RecoveryState, bool>(
          bloc: (context).read<RecoveryBloc>(),
          selector: (RecoveryState state) => state.isLoading,
          builder: (BuildContext context, bool isLoading) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container();
            }
          })
    ]);
  }

  _onInputChange(BuildContext context, String value, String name) {
    context.read<RecoveryBloc>().add(ChangeNodeValue(value: value, name: name));
  }

  _onInputSubmit(
      BuildContext context, UiNodeGroupEnum group, String name, String value) {
    context
        .read<RecoveryBloc>()
        .add(UpdateRecoveryFlow(group: group, name: name, value: value));
  }
}
