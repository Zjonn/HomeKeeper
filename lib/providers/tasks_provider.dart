import 'package:artemis/client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Task {}

class TaskInstance {}

class TasksProvider with ChangeNotifier {
  late final ArtemisClient _client;

  TasksProvider(this._client);

}
