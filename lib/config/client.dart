// based on https://hasura.io/learn/graphql/flutter-graphql/graphql-client/
import 'package:artemis/artemis.dart';
import 'package:http/http.dart' as http;

class HttpClientWithToken extends http.BaseClient {
  HttpClientWithToken(this.token);

  final String token;
  final http.Client _client = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = token;
    print(token);
    return _client.send(request);
  }
}

ArtemisClient initializeClient(String url, String token) {
  return ArtemisClient(url, httpClient: HttpClientWithToken("JWT " + token));
}
