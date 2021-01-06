@TestOn("vm")
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:artemis/artemis.dart';

import 'package:home_keeper/auth_provider.dart';

class MockHttpClient extends Mock implements http.Client {}

NormalizedInMemoryCache getTestCache() => NormalizedInMemoryCache(
      dataIdFromObject: typenameDataIdFromObject,
    );

http.StreamedResponse simpleResponse({String body, int status}) {
  final List<int> bytes = utf8.encode(body);
  final Stream<List<int>> stream =
      Stream<List<int>>.fromIterable(<List<int>>[bytes]);

  final http.StreamedResponse r = http.StreamedResponse(stream, status ?? 200);

  return r;
}

void main() {
  ArtemisClient artemisClient;
  MockHttpClient mockHttpClient;
  AuthProvider authProvider;

  group(
    'authProvider',
    () {
      setUp(() {
        mockHttpClient = MockHttpClient();

        artemisClient = ArtemisClient('http://localhost:3001/graphql',
            httpClient: mockHttpClient);

        authProvider = AuthProvider.withMocks(artemisClient);
      });

      // TODO complete this test to actually check something
      test(
        'loginUser',
        () async {
          when(mockHttpClient.send(any)).thenAnswer((Invocation a) async {
            return simpleResponse(body: '''{
              "data": {
                "tokenAuth": {
                  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6IkFnYXRrYSIsImV4cCI6MTYwOTY5NzgzOCwib3JpZ0lhdCI6MTYwOTY5NzUzOH0.635kP0r4v9yckzCU-y0wPEL6tJBb803eIsJbyVbMJzs",
                  "refreshExpiresIn": 1610302338
                }
              }
            } ''');
          });
          authProvider.login("username", "password");
          await untilCalled(mockHttpClient.send(any));
        },
      );
    },
  );
}
