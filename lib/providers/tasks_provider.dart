import 'package:artemis/client.dart';
import 'package:flutter/cupertino.dart';

import 'package:home_keeper/graphql/graphql_api.dart';

class Task {}

class TaskInstance {}

class TasksProvider with ChangeNotifier {
  late final ArtemisClient _client;

  TasksProvider(this._client);

  void listUserTasks() {
    _client.execute(ListUserTeamsInfoQuery());
  }
}
