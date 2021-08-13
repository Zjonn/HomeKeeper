import 'package:flutter/material.dart';
import 'package:home_keeper/config/api_url.dart';

class ApiURLProvider extends ChangeNotifier {
  static final String initialApiURL = ApiUrl.URL;

  String _apiURL = ApiUrl.URL;

  String get apiURL => _apiURL;

  set apiURL(String val) {
    if (val != _apiURL) {
      _apiURL = val;
      notifyListeners();
    }
  }
}
