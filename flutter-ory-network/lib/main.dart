// Copyright © 2023 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ory_network_flutter/pages/settings.dart';
import 'package:ory_network_flutter/widgets/helpers.dart';
import 'package:ory_network_flutter/widgets/ory_theme.dart';
import 'dart:io' show Platform;

import 'blocs/auth/auth_bloc.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/entry.dart';

import 'repositories/auth.dart';
import 'services/auth.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final baseUrl = dotenv.get('ORY_BASE_URL');

  // create the dio client for http requests
  final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10000),
    receiveTimeout: const Duration(seconds: 5000),
    headers: {
      'Accept': 'application/json',
    },
    validateStatus: (status) {
      // prevent the request from throwing null exception
      return status != null && status < 500 ? true : false;
    },
  );
  final dio = DioForNative(options);

  final authService = AuthService(dio);

// We use Web Client ID for Android devices as omitting Client ID
// leads to id Token being null. For more information,
// see https://github.com/flutter/flutter/issues/33393#issuecomment-964728679
  final googleSignIn = GoogleSignIn.instance;

  googleSignIn.initialize(
      clientId: Platform.isAndroid
          ? dotenv.get('WEB_CLIENT_ID')
          : dotenv.get('IOS_CLIENT_ID'));
  final authRepository =
      AuthRepository(googleSignIn: googleSignIn, service: authService);
  runApp(RepositoryProvider.value(
      value: authRepository,
      child: BlocProvider(
        create: (context) => AuthBloc(repository: authRepository)
          ..add(GetCurrentSessionInformation()),
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Ory Network Demo',
      home: MyAppView(),
    );
  }
}

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: OryTheme.defaultTheme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          // navigate to pages only when auth status has changed
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            state.mapOrNull(unauthenticated: (_) {
              _navigator.pushAndRemoveUntil<void>(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const LoginPage(aal: 'aal1')),
                  (Route<dynamic> route) => false);
            }, authenticated: (authState) {
              // if user is authenticated and didn't request a recovery,
              // navigate to home page
              if (!isRecoveryRequired(authState.conditions)) {
                _navigator.pushAndRemoveUntil<void>(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => const HomePage()),
                    (Route<dynamic> route) => false);
              } else {
                // otherwise, navigate to settings page
                // with provided settings flow id
                final recovery = authState.conditions.firstWhereOrNull(
                        (element) => element is RecoveryRequested)!
                    as RecoveryRequested;

                _navigator.pushAndRemoveUntil<void>(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => SettingsPage(
                              flowId: recovery.settingsFlowId,
                            )),
                    (route) => false);
              }
            }, aal2Requested: (authState) {
              _navigator.pushAndRemoveUntil<void>(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => LoginPage(
                          conditions: authState.conditions, aal: 'aal2')),
                  (Route<dynamic> route) => false);
            });
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => MaterialPageRoute<void>(
          builder: (BuildContext context) => const EntryPage()),
    );
  }
}
