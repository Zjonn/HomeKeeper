import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/providers/connection_provider.dart';

enum AuthClientProviderState { Initialized, InProgress }

class AuthClientProvider extends ChangeNotifier {
  late final ArtemisClientWithTimeout _client;
  late final FlutterSecureStorage _storage;

  var _state = AuthClientProviderState.InProgress;

  get state => _state;

  get client => _client;

  AuthClientProvider(ConnectionProvider provider) {
    _storage = FlutterSecureStorage();
    _initialize(provider);
  }

  AuthClientProvider.withMocks(this._storage, this._client);

  Future<void> _initialize(ConnectionProvider provider) async {
    String token = (await this._storage.read(key: "token"))!;
    final httpClient = HttpClientWithToken("JWT " + token);

    _client = provider.createClient(httpClient: httpClient);

    _state = AuthClientProviderState.Initialized;
    notifyListeners();
  }
}
