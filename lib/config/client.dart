// based on https://hasura.io/learn/graphql/flutter-graphql/graphql-client/

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:home_keeper/config/api_url.dart';

class Config {
  static final HttpLink httpLink = HttpLink(
    uri: ApiUrl.URL,
  );

  static String _token;

  static final AuthLink authLink = AuthLink(getToken: () => _token);

  // static final WebSocketLink websocketLink = WebSocketLink(
  //   url: 'wss://hasura.io/learn/graphql',
  //   config: SocketClientConfig(
  //     autoReconnect: true,
  //     inactivityTimeout: Duration(seconds: 30),
  //     initPayload: {
  //       'headers': {'Authorization': _token},
  //     },
  //   ),
  // );

  static final Link link = authLink.concat(httpLink);

  static String token;

  static ValueNotifier<GraphQLClient> initializeClient(String token) {
    _token = token;

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: link,
      ),
    );

    return client;
  }
}
