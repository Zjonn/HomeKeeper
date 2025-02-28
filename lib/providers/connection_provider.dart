import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/config/constants.dart';
import 'package:http/http.dart' as http;

enum ConnectionProviderState {
  Connected,
  CheckInProgress,
  NoInternetConnection,
  NoBackendConnection,
}

class ConnectionProvider extends ChangeNotifier {
  static final String defaultApiURL = Constants.API_URL;

  final FlutterSecureStorage _storage;
  late final http.Client _client;

  ConnectionProviderState _state = ConnectionProviderState.Connected;

  String _apiURL = Constants.API_URL;

  bool updatingState = false;

  String get apiURL => _apiURL;

  ConnectionProviderState get state => _state;

  set apiURL(String val) {
    if (val != _apiURL) {
      _apiURL = val;
      _storage.write(key: 'api_url', value: _apiURL);
      notifyListeners();
    }
  }

  ConnectionProvider(
      [this._storage = const FlutterSecureStorage(), http.Client? client]) {
    _client = client == null ? http.Client() : client;

    _storage.read(key: 'api_url').then((value) {
      if (value?.isEmpty ?? true) {
        _storage.write(key: 'api_url', value: _apiURL);
      } else {
        _apiURL = value!;
      }
      notifyListeners();
    });
  }

  Future<void> updateState() async {
    if (updatingState) {
      return;
    }
    updatingState = true;

    _state = ConnectionProviderState.CheckInProgress;
    notifyListeners();

    try {
      await _client
          .get(Uri.parse('https://www.google.com/'))
          .timeout(Constants.TIMEOUT);
    } on TimeoutException {
      _state = ConnectionProviderState.NoInternetConnection;
      updatingState = false;
      notifyListeners();
      return;
    } catch (e) {}

    try {
      await _client.get(Uri.parse(_apiURL)).timeout(Constants.TIMEOUT);
      _state = ConnectionProviderState.Connected;
    } on TimeoutException {
      _state = ConnectionProviderState.NoBackendConnection;
    } catch (e) {}

    updatingState = false;
    notifyListeners();
  }

  ArtemisClientWithTimeout createClient({http.Client? httpClient}) {
    return ArtemisClientWithTimeout(apiURL,
        httpClient: httpClient, onTimeout: updateState);
  }
}
