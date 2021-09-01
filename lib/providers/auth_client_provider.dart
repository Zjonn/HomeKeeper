import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';

enum AuthClientProviderState {
  Initialized,
  NoConnectionWithBackend,
  NoInternetConnection,
  InProgress
}

class AuthClientProvider extends ChangeNotifier {
  late final ArtemisClientWithTimeout _client;
  late final FlutterSecureStorage _storage;

  var _state = AuthClientProviderState.InProgress;

  get state => _state;

  get client => _client;

  AuthClientProvider(String apiUrl) {
    _storage = FlutterSecureStorage();
    _initialize(apiUrl);
  }

  AuthClientProvider.withMocks(this._storage, this._client);

  Future<void> _initialize(String apiUrl) async {
    String token = (await this._storage.read(key: "token"))!;
    _client = ArtemisClientWithTimeout(apiUrl,
        httpClient: HttpClientWithToken("JWT " + token),
        onTimeout: handleClientTimeout);

    _state = AuthClientProviderState.Initialized;
    notifyListeners();
  }

  void handleClientTimeout() {
    _state = AuthClientProviderState.NoConnectionWithBackend;
    notifyListeners();
  }
}
