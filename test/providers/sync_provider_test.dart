import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_keeper/config/constants.dart';
import 'package:home_keeper/providers/sync_provider.dart';
import 'package:mockito/mockito.dart';

import '../utils/MockCallbackFunction.dart';

void main() {
  final notifyListenerCallback = MockCallbackFunction();
  late SyncProvider syncProvider;

  group('SyncProvider', () {
    setUp(() {
      syncProvider = SyncProvider();
      reset(notifyListenerCallback);
      syncProvider.addListener(notifyListenerCallback);
    });

    test('Timer is active', () async {
      expect(syncProvider.isDisposed, false);
      expect(syncProvider.syncTimer.isActive, true);
    });

    test('Tick calls listeners', () async {
      syncProvider.triggerSync();
      verify(notifyListenerCallback());
    });

    test('Dispose disables timer', () async {
      syncProvider.dispose();

      expect(syncProvider.syncTimer.isActive, false);
      expect(syncProvider.isDisposed, true);
    });
  });
}
