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

  AuthClientProvider() {
    _storage = FlutterSecureStorage();
    _initialize().then((value) => null);
  }

  AuthClientProvider.withMocks(_storage);

  Future<void> _initialize() async {
    String token = (await this._storage.read(key: "token"))!;
    _client = initializeClient(token);

    _state = ClientState.Initialized;
    notifyListeners();
  }
}
