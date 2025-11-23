// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../repositories/auth.dart';
import '../widgets/helpers.dart';
import 'recovery.dart';
import 'registration.dart';

class LoginPage extends StatelessWidget {
  final List<Condition> conditions;
  final String aal;

  const LoginPage({super.key, this.conditions = const [], required this.aal});

  @override
  Widget build(BuildContext context) {
    final sessionRefreshRequested = isSessionRefreshRequired(conditions);
    return BlocListener<AuthBloc, AuthState>(
      // navigate to previous page only if the user refreshed the session
      listenWhen: (previous, current) {
        final previousSession =
            previous.mapOrNull(authenticated: (value) => value.session);
        final currentSession =
            current.mapOrNull(authenticated: (value) => value.session);
        final sessionRefreshRequested = isSessionRefreshRequired(conditions);
        return previousSession != currentSession &&
            previousSession != null &&
            currentSession != null &&
            sessionRefreshRequested;
      },
      listener: (context, state) {
        Navigator.of(context).pop(true);
      },
      child: Scaffold(
        extendBodyBehindAppBar: !sessionRefreshRequested,
        appBar: sessionRefreshRequested
            ? AppBar(
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
                ))
            : null,
        body: BlocProvider(
            create: (context) => LoginBloc(
                authBloc: context.read<AuthBloc>(),
                repository: RepositoryProvider.of<AuthRepository>(context),
                conditions: conditions)
              ..add(CreateLoginFlow(aal: aal)),
            child: LoginForm(isSessionRefresh: sessionRefreshRequested)),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final bool isSessionRefresh;

  const LoginForm({super.key, this.isSessionRefresh = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.loginFlow != null) {
          return _buildUi(context, state);
        } else {
          return buildFlowNotCreated(context, state.message);
        }
      },
    );
  }

  Widget _buildUi(BuildContext context, LoginState state) {
    final nodes = state.loginFlow!.ui.nodes;

    // get default nodes from all nodes
    final defaultNodes = getNodesOfGroup(UiNodeGroupEnum.default_, nodes);

    // get code nodes from all nodes
    final codeNodes = getNodesOfGroup(UiNodeGroupEnum.code, nodes);

    // get password nodes from all nodes
    final passwordNodes = getNodesOfGroup(UiNodeGroupEnum.password, nodes);

    // get lookup secret nodes from all nodes
    final lookupSecretNodes =
        getNodesOfGroup(UiNodeGroupEnum.lookupSecret, nodes);

    // get totp nodes from all nodes
    final totpNodes = getNodesOfGroup(UiNodeGroupEnum.totp, nodes);

    // get oidc nodes from all nodes
    final oidcNodes = getNodesOfGroup(UiNodeGroupEnum.oidc, nodes);

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
              if (!isSessionRefresh)
                Padding(
                  padding: EdgeInsets.only(
                      //status bar height + padding
                      top: MediaQuery.of(context).viewPadding.top + 48),
                  child: Image.asset(
                    'assets/images/ory_logo.png',
                    width: 70,
                  ),
                ),
              // show header depending on auth state
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: BlocSelector<AuthBloc, AuthState, bool>(
                  bloc: (context).read<AuthBloc>(),
                  selector: (AuthState state) =>
                      state.status == AuthStatus.aal2Requested,
                  builder: (BuildContext context, bool boolState) {
                    return Text(
                        boolState ? 'Two-Factor Authentication' : 'Sign in',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 18));
                  },
                ),
              ),

              if (oidcNodes.isNotEmpty)
                buildGroup<LoginBloc>(context, UiNodeGroupEnum.oidc, oidcNodes,
                    _onInputChange, _onInputSubmit),
              if (defaultNodes.isNotEmpty)
                buildGroup<LoginBloc>(context, UiNodeGroupEnum.default_,
                    defaultNodes, _onInputChange, _onInputSubmit),
              if (codeNodes.isNotEmpty)
                buildGroup<LoginBloc>(context, UiNodeGroupEnum.code, codeNodes,
                    _onInputChange, _onInputSubmit),
              if (passwordNodes.isNotEmpty)
                Column(
                  children: [
                    buildGroup<LoginBloc>(context, UiNodeGroupEnum.password,
                        passwordNodes, _onInputChange, _onInputSubmit),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RecoveryPage())),
                            child: const Text("Forgot password?"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              if (lookupSecretNodes.isNotEmpty)
                buildGroup<LoginBloc>(context, UiNodeGroupEnum.lookupSecret,
                    lookupSecretNodes, _onInputChange, _onInputSubmit),
              if (totpNodes.isNotEmpty)
                buildGroup<LoginBloc>(context, UiNodeGroupEnum.totp, totpNodes,
                    _onInputChange, _onInputSubmit),
              const SizedBox(
                height: 32,
              ),
              if (state.loginFlow?.ui.messages != null)
                for (var message in state.loginFlow!.ui.messages!)
                  Text(
                    message.text,
                    style: TextStyle(color: getMessageColor(message.type)),
                  ),
              // show logout button if aal2 requested, otherwise sign up
              BlocSelector<AuthBloc, AuthState, bool>(
                  bloc: (context).read<AuthBloc>(),
                  selector: (AuthState state) =>
                      state.status == AuthStatus.aal2Requested,
                  builder: (BuildContext context, bool isAal2Requested) {
                    if (isAal2Requested || isSessionRefresh) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Something\'s not working?'),
                          TextButton(
                              onPressed: () =>
                                  (context).read<AuthBloc>().add(LogOut()),
                              child: const Text('Logout'))
                        ],
                      );
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('No account?'),
                          TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationPage())),
                              child: const Text('Sign up'))
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
      // build progress indicator when state is loading
      BlocSelector<LoginBloc, LoginState, bool>(
          bloc: (context).read<LoginBloc>(),
          selector: (LoginState state) => state.isLoading,
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
      BlocSelector<LoginBloc, LoginState, bool>(
          bloc: (context).read<LoginBloc>(),
          selector: (LoginState state) => state.isLoading,
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
    context.read<LoginBloc>().add(ChangeNodeValue(value: value, name: name));
  }

  _onInputSubmit(
      BuildContext context, UiNodeGroupEnum group, String name, String value) {
    context
        .read<LoginBloc>()
        .add(UpdateLoginFlow(group: group, name: name, value: value));
  }
}
