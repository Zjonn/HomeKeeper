// https://medium.com/@afegbua/flutter-thursday-13-building-a-user-registration-and-login-process-with-provider-and-external-api-1bb87811fd1d

import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:home_keeper/config/api_url.dart';
import 'package:home_keeper/graphql/graphql_api.dart';

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

class RegisterResult {
  bool status;
  GraphQLResponse<RegisterUser$Mutation> response;

  RegisterResult(this.status, this.response);
}

class LoginResult {
  bool status;
  GraphQLResponse<LoginUser$Mutation> response;

  LoginResult(this.status, this.response);
}

class AuthProvider with ChangeNotifier {
  ArtemisClient _client = ArtemisClient(ApiUrl.URL);
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Status _loggedInStatus = Status.Uninitialized;
  Status _registeredInStatus = Status.Uninitialized;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  AuthProvider(String apiUrl) {
    _client = ArtemisClient(apiUrl);
    isTokenValid().then((value) => null);
  }

  AuthProvider.withMocks(this._client, this._storage);

  Future<void> isTokenValid() async {
    _loggedInStatus = Status.NotLoggedIn;
    _registeredInStatus = Status.NotRegistered;

    final token = await _storage.read(key: "token");
    if (token?.isEmpty ?? true) {
      notifyListeners();
      return;
    }

    final response = await _client.execute(
        IsTokenValidMutation(variables: IsTokenValidArguments(token: token)));
    if (!response.hasErrors) {
      _loggedInStatus = Status.LoggedIn;
      _registeredInStatus = Status.NotRegistered;
    }
    notifyListeners();
  }

  Future<LoginResult> login(String username, String password) async {
    var result;

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    final loginMutation = LoginUserMutation(
        variables: LoginUserArguments(username: username, password: password));

    final response = await this
        ._client
        .execute(loginMutation)
        .timeout(Duration(seconds: 2), onTimeout: () {
      return GraphQLResponse(
          errors: [GraphQLError(message: "No internet connection")]);
    });

    if (!response.hasErrors) {
      await this
          ._storage
          .write(key: "token", value: response.data!.tokenAuth!.token);

      _loggedInStatus = Status.LoggedIn;
      result = LoginResult(true, response);
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      result = LoginResult(false, response);
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

    if (response.hasErrors) {
      return _onError(response);
    } else {
      return _onValue(response);
    }
  }

  Future<RegisterResult> _onValue(
      GraphQLResponse<RegisterUser$Mutation> response) async {
    var result;

    if (response.data!.register!.errors?.isEmpty ?? true) {
      _registeredInStatus = Status.Registered;
      result = RegisterResult(true, response);
    } else {
      _registeredInStatus = Status.NotRegistered;
      result = RegisterResult(false, response);
    }
    notifyListeners();
    return result;
  }

  RegisterResult _onError(GraphQLResponse<RegisterUser$Mutation> response) {
    _registeredInStatus = Status.NotRegistered;
    notifyListeners();
    return RegisterResult(false, response);
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();
  }
}
