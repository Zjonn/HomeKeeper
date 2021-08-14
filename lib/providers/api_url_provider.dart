import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/api_url.dart';

class ApiURLProvider extends ChangeNotifier {
  static final String defaultApiURL = ApiUrl.URL;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  String _apiURL = ApiUrl.URL;

  String get apiURL => _apiURL;

  set apiURL(String val) {
    if (val != _apiURL) {
      _apiURL = val;
      _storage.write(key: 'api_url', value: _apiURL);
      notifyListeners();
    }
  }

  ApiURLProvider() {
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
