// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter_test/flutter_test.dart';
import 'package:ory_network_flutter/blocs/auth/auth_bloc.dart';
import 'package:ory_network_flutter/widgets/helpers.dart';

void main() {
  group('condition helpers', () {
    test('no conditions means nothing is required', () {
      expect(isSessionRefreshRequired([]), isFalse);
      expect(isRecoveryRequired([]), isFalse);
    });

    test('a session refresh condition only asks for a refresh', () {
      final conditions = <Condition>[SessionRefreshRequested()];
      expect(isSessionRefreshRequired(conditions), isTrue);
      expect(isRecoveryRequired(conditions), isFalse);
    });

    test('a recovery condition only asks for recovery', () {
      final conditions = <Condition>[RecoveryRequested(settingsFlowId: 'flow-id')];
      expect(isRecoveryRequired(conditions), isTrue);
      expect(isSessionRefreshRequired(conditions), isFalse);
    });

    test('conditions are matched by type, not by position', () {
      final conditions = <Condition>[
        RecoveryRequested(settingsFlowId: 'flow-id'),
        SessionRefreshRequested(),
      ];
      expect(isSessionRefreshRequired(conditions), isTrue);
      expect(isRecoveryRequired(conditions), isTrue);
    });
  });
}
