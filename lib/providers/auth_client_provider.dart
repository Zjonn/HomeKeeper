import 'package:artemis/artemis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';

enum State { ClientInitialized, ClientUninitialized }

class ClientProvider extends ChangeNotifier {
  late final ArtemisClient _client;
  late final FlutterSecureStorage _storage;

  var _state = State.ClientUninitialized;

  get state => _state;

  get client => _client;

  ClientProvider();

  ClientProvider.withMocks(_storage);

  void initialize() async {
    if (_state == State.ClientUninitialized) {
      String token = (await this._storage.read(key: "token"))!;
      _client = initializeClient(token);

      _state = State.ClientInitialized;
      notifyListeners();
    }
  }
}
