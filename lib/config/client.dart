import 'dart:async';

import 'package:artemis/artemis.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:home_keeper/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class HttpClientWithToken extends http.BaseClient {
  HttpClientWithToken(this.token);

  final String token;
  final http.Client _client = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = token;
    print(request.url);
    return _client.send(request);
  }
}

class ArtemisClientWithTimeout extends ArtemisClient {
  final Duration timeout;
  final Function()? onTimeout;

  ArtemisClientWithTimeout(String url,
      {http.Client? httpClient,
      this.timeout = Constants.TIMEOUT,
      this.onTimeout})
      : super.fromLink(HttpLink(
          url,
          httpClient: httpClient,
        ));

  @override
  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
      GraphQLQuery<T, U> query,
      {Context context = const Context()}) {
    return super.execute<T, U>(query, context: context).timeout(timeout,
        onTimeout: () async {
      if (onTimeout != null) {
        await onTimeout!();
      }
      return GraphQLResponse(errors: [GraphQLError(message: "")]);
    });
  }
}
