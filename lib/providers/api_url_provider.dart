import 'package:flutter/material.dart';
import 'package:home_keeper/config/api_url.dart';

class ApiUrlProvider extends ChangeNotifier {
  static final String initialApiUrl = ApiUrl.URL;

  String apiUrl = ApiUrl.URL;
}
