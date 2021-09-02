import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/constants.dart';

class ApiURLProvider extends ChangeNotifier {
  static final String defaultApiURL = Constants.API_URL;

  final FlutterSecureStorage _storage;

  String _apiURL = Constants.API_URL;

  String get apiURL => _apiURL;

  set apiURL(String val) {
    if (val != _apiURL) {
      _apiURL = val;
      _storage.write(key: 'api_url', value: _apiURL);
      notifyListeners();
    }
  }

  ApiURLProvider([this._storage = const FlutterSecureStorage()]) {
    _storage.read(key: 'api_url').then((value) {
      if (value?.isEmpty ?? true) {
        _storage.write(key: 'api_url', value: _apiURL);
      } else {
        _apiURL = value!;
        notifyListeners();
      }
    });
  }
}
