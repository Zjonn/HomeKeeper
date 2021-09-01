import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/config/client.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/providers/auth_provider/results.dart';

enum Status {
  Uninitialized,
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  late final ArtemisClientWithTimeout _client;
  late final FlutterSecureStorage _storage;

  bool _isDisposed = false;

  Status _loggedInStatus = Status.Uninitialized;
  Status _registeredInStatus = Status.Uninitialized;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  AuthProvider(String apiUrl, [client, storage]) {
    _client = client == null ? ArtemisClientWithTimeout(apiUrl) : client;
    _storage = storage == null ? FlutterSecureStorage() : storage;

    isTokenValid();
  }

  AuthProvider.withMocks(this._client, this._storage);

  Future<void> isTokenValid() async {
    _loggedInStatus = Status.NotLoggedIn;
    _registeredInStatus = Status.NotRegistered;

    final token = await _storage.read(key: "token");
    if (token?.isEmpty ?? true) {
      _disposeSafeNotifyListeners();
      return;
    }

    final response = await _client.execute(
        IsTokenValidMutation(variables: IsTokenValidArguments(token: token)));
    if (!response.hasErrors) {
      _loggedInStatus = Status.LoggedIn;
      _registeredInStatus = Status.NotRegistered;
    }
    _disposeSafeNotifyListeners();
  }

  Future<LoginResult> login(String username, String password) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    final loginMutation = LoginUserMutation(
        variables: LoginUserArguments(username: username, password: password));

    final response = await this._client.execute(loginMutation);
    final result = LoginResult(response);

    if (result.isSuccessful) {
      await this
          ._storage
          .write(key: "token", value: response.data!.tokenAuth!.token);

      _loggedInStatus = Status.LoggedIn;
    } else {
      _loggedInStatus = Status.NotLoggedIn;
    }

    notifyListeners();
    return result;
  }

  Future<RegisterResult> register(String username, String email,
      String password, String passwordConfirmation) async {
    final registerMutation = RegisterUserMutation(
        variables: RegisterUserArguments(
            input: RegisterInput(
                username: username,
                password1: password,
                password2: passwordConfirmation,
                email: email)));

    _registeredInStatus = Status.Registering;
    notifyListeners();

    final response = await this._client.execute(registerMutation);

    final result = RegisterResult(response);
    if (result.isSuccessful) {
      _registeredInStatus = Status.Registered;
    } else {
      _registeredInStatus = Status.NotRegistered;
    }
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void _disposeSafeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
