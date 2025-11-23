// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/registration/registration_bloc.dart';
import '../repositories/auth.dart';
import '../widgets/helpers.dart';
import 'login.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => RegistrationBloc(
              authBloc: context.read<AuthBloc>(),
              repository: RepositoryProvider.of<AuthRepository>(context))
            ..add(CreateRegistrationFlow()),
          child: const RegistrationForm()),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<StatefulWidget> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.registrationFlow != null) {
          return _buildUi(context, state);
        } else {
          return buildFlowNotCreated(context, state.message);
        }
      },
    );
  }

  _buildUi(BuildContext context, RegistrationState state) {
    final nodes = state.registrationFlow!.ui.nodes;

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
              Padding(
                padding: EdgeInsets.only(
                    //status bar height + padding
                    top: MediaQuery.of(context).viewPadding.top + 48),
                child: Image.asset(
                  'assets/images/ory_logo.png',
                  width: 70,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text('Sign up',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, height: 1.5, fontSize: 18)),
              if (oidcNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(context, UiNodeGroupEnum.oidc,
                    oidcNodes, _onInputChange, _onInputSubmit),
              if (defaultNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(context, UiNodeGroupEnum.default_,
                    defaultNodes, _onInputChange, _onInputSubmit),
              if (codeNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(context, UiNodeGroupEnum.code,
                    codeNodes, _onInputChange, _onInputSubmit),
              if (passwordNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(context, UiNodeGroupEnum.password,
                    passwordNodes, _onInputChange, _onInputSubmit),
              if (lookupSecretNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(
                    context,
                    UiNodeGroupEnum.lookupSecret,
                    lookupSecretNodes,
                    _onInputChange,
                    _onInputSubmit),
              if (totpNodes.isNotEmpty)
                buildGroup<RegistrationBloc>(context, UiNodeGroupEnum.totp,
                    totpNodes, _onInputChange, _onInputSubmit),
              const SizedBox(
                height: 32,
              ),
              if (state.registrationFlow?.ui.messages != null)
                for (var message in state.registrationFlow!.ui.messages!)
                  Text(
                    message.text,
                    style: TextStyle(color: getMessageColor(message.type)),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginPage(
                                    aal: 'aal1',
                                  ))),
                      child: const Text('Sign in'))
                ],
              )
            ],
          ),
        ),
      ),
      // build progress indicator when state is loading
      BlocSelector<RegistrationBloc, RegistrationState, bool>(
          bloc: (context).read<RegistrationBloc>(),
          selector: (RegistrationState state) => state.isLoading,
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
      BlocSelector<RegistrationBloc, RegistrationState, bool>(
          bloc: (context).read<RegistrationBloc>(),
          selector: (RegistrationState state) => state.isLoading,
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
    context
        .read<RegistrationBloc>()
        .add(ChangeNodeValue(value: value, name: name));
  }

  _onInputSubmit(
      BuildContext context, UiNodeGroupEnum group, String name, String value) {
    context
        .read<RegistrationBloc>()
        .add(UpdateRegistrationFlow(group: group, name: name, value: value));
  }
}
