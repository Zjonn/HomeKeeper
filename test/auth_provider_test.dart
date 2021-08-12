import 'dart:convert';

import 'package:artemis/client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
@TestOn("vm")
import 'package:test/test.dart';

import 'auth_provider_test.mocks.dart';

http.StreamedResponse simpleResponse(String body, {int? status}) {
  final List<int> bytes = utf8.encode(body);
  final Stream<List<int>> stream =
      Stream<List<int>>.fromIterable(<List<int>>[bytes]);

  final http.StreamedResponse r = http.StreamedResponse(stream, status ?? 200);

  return r;
}

@GenerateMocks([http.Client, FlutterSecureStorage])
void main() {
  late ArtemisClient artemisClient;
  late MockClient mockHttpClient;
  late AuthProvider authProvider;
  late MockFlutterSecureStorage mockStorage;

  group('AuthProvider', () {
    setUp(() {
      mockHttpClient = MockClient();
      mockStorage = MockFlutterSecureStorage();

      artemisClient = ArtemisClient('http://localhost:3001/graphql',
          httpClient: mockHttpClient);

      authProvider = AuthProvider.withMocks(artemisClient, mockStorage);
    });

    test('initialState', () async {
      expect(authProvider.loggedInStatus, Status.Uninitialized);
      expect(authProvider.registeredInStatus, Status.Uninitialized);
    });

    test(
      'loginUser',
      () async {
        when(mockHttpClient.send(any))
            .thenAnswer((Invocation a) async => simpleResponse('''{
            "data": {
              "tokenAuth": {
                "token": "token_value",
                "refreshExpiresIn": 1610302338
              }
            }
          } '''));

        final res = await authProvider.login("username", "password");
        expect(res.status, true);
        expect(authProvider.loggedInStatus, Status.LoggedIn);

        verify(mockStorage.write(key: "token", value: "token_value"));
      },
    );

    test(
      'failingLoginUser',
      () async {
        when(mockHttpClient.send(any))
            .thenAnswer((Invocation a) async => simpleResponse('''{
            "errors": [
              {
                "message": ""
              }
            ],
            "data": null
          } '''));

        final res = await authProvider.login("username", "password");
        expect(res.status, false);
        expect(authProvider.loggedInStatus, Status.NotLoggedIn);

        verifyZeroInteractions(mockStorage);
      },
    );

    test('logout', () async {
      await authProvider.logout();

      expect(authProvider.loggedInStatus, Status.LoggedOut);
      verify(mockStorage.delete(key: "token"));
    });

    test('missingToken', () async {
      when(mockStorage.read(
              key: anyNamed("key"),
              iOptions: anyNamed("iOptions"),
              lOptions: anyNamed("lOptions")))
          .thenAnswer((realInvocation) async => null);

      await authProvider.isTokenValid();

      expect(authProvider.loggedInStatus, Status.NotLoggedIn);
      expect(authProvider.registeredInStatus, Status.NotRegistered);
    });

    test('invalidToken', () async {
      when(mockStorage.read(
              key: anyNamed("key"),
              iOptions: anyNamed("iOptions"),
              lOptions: anyNamed("lOptions")))
          .thenAnswer((realInvocation) async => "BEE3");

      when(mockHttpClient.send(any))
          .thenAnswer((Invocation a) async => simpleResponse('''{
            "errors": [
              {
                "message": ""
              }
            ],
            "data": null
          } '''));

      await authProvider.isTokenValid();

      expect(authProvider.loggedInStatus, Status.NotLoggedIn);
      expect(authProvider.registeredInStatus, Status.NotRegistered);
    });

    test('validToken', () async {
      when(mockStorage.read(
              key: anyNamed("key"),
              iOptions: anyNamed("iOptions"),
              lOptions: anyNamed("lOptions")))
          .thenAnswer((realInvocation) async => "BEE3");

      when(mockHttpClient.send(any))
          .thenAnswer((Invocation a) async => simpleResponse('''{
            "data": {
              "__payload": ""
            }
          } '''));

      await authProvider.isTokenValid();

      expect(authProvider.loggedInStatus, Status.LoggedIn);
      expect(authProvider.registeredInStatus, Status.NotRegistered);
    });
  });
}
