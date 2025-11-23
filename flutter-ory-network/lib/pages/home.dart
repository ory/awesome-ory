// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ory_client/ory_client.dart';
import 'package:ory_network_flutter/pages/settings.dart';

import '../blocs/auth/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // get current session information when the page opens
    context.read<AuthBloc>().add(GetCurrentSessionInformation());
  }

  @override
  Widget build(BuildContext context) {
    // get loading state
    final isLoading =
        context.select((AuthBloc authBloc) => authBloc.state.isLoading);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Image.asset(
            'assets/images/ory_logo.png',
            width: 40,
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage())),
              icon: Image.asset('assets/icons/settings.png'),
            ),
            // if auth is loading, show progress indicator, otherwise a logout icon
            isLoading
                ? const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Center(
                      widthFactor: 1,
                      heightFactor: 1,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () => context.read<AuthBloc>()..add(LogOut()),
                    icon: Image.asset('assets/icons/logout.png'),
                  ),
          ],
        ),
        body: BlocBuilder(
          bloc: context.read<AuthBloc>(),
          builder: (BuildContext context, AuthState state) {
            switch (state) {
              case AuthAuthenticated(session: var session):
                return _buildSessionInformation(context, session);
              default:
                return _buildSessionNotFetched(context, state);
            }
          },
        ));
  }

  _buildSessionInformation(BuildContext context, Session session) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              'Welcome back,\n${session.identity?.id}!',
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 35),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                  'Hello, nice to have you! You signed up with this data:'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                padding: const EdgeInsets.all(35),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[600]),
                child: Text(session.identity!.traits.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                    'This app makes REST requests to Ory Kratos Public API to validate and decode the Ory Kratos Session payload:')),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                padding: const EdgeInsets.all(35),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[600]),
                child: Text(session.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSessionNotFetched(BuildContext context, AuthState state) {
    if (state.errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
            child: Text(
          state.errorMessage!,
          style: const TextStyle(color: Colors.red),
        )),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
