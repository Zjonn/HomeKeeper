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

  group('authProvider', () {
    setUp(() {
      mockHttpClient = MockClient();
      mockStorage = MockFlutterSecureStorage();

      artemisClient = ArtemisClient('http://localhost:3001/graphql',
          httpClient: mockHttpClient);

      authProvider = AuthProvider.withMocks(artemisClient, mockStorage);
    });

    // TODO complete this test to actually check something
    test(
      'loginUser',
      () async {
        when(mockHttpClient.send(http.Request("Test", Uri())))
            .thenAnswer((Invocation a) async => simpleResponse('''{
            "data": {
              "tokenAuth": {
                "token": "token_value",
                "refreshExpiresIn": 1610302338
              }
            }
          } '''));

        await authProvider.login("username", "password");
        verify(mockStorage.write(key: "token", value: "token_value"));
      },
    );
  });
}
