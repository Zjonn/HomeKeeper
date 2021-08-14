import 'package:artemis/artemis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';

enum ClientState { Initialized, InProgress }

class AuthClientProvider extends ChangeNotifier {
  late final ArtemisClient _client;
  late final FlutterSecureStorage _storage;

  var _state = ClientState.InProgress;

  get state => _state;

  get client => _client;

  AuthClientProvider(String apiUrl) {
    _storage = FlutterSecureStorage();
    _initialize(apiUrl);
  }

  AuthClientProvider.withMocks(this._storage);

  Future<void> _initialize(String apiUrl) async {
    String token = (await this._storage.read(key: "token"))!;
    _client = initializeClient(apiUrl, token);

    _state = ClientState.Initialized;
    notifyListeners();
  }
}
