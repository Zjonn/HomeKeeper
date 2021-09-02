import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:home_keeper/config/constants.dart';

class SyncProvider extends ChangeNotifier {
  late Timer syncTimer;
  bool isDisposed = false;

  SyncProvider() {
    syncTimer =
        Timer.periodic(Constants.SYNC_DURATION, (Timer timer) => triggerSync());
  }

  void triggerSync() {
    if (!isDisposed) {
      notifyListeners();
      print("Synced");
    }
  }

  @override
  void dispose() {
    isDisposed == true;
    syncTimer.cancel();
    super.dispose();
  }
}
