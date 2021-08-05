import 'package:home_keeper/graphql/graphql_api.dart';

class Task {
  late final String id;
  late final String name;
  late final String description;

  late final int points;

  Task(this.id, this.name, this.description, this.points);

  Task.fromResp(ListTasks$Query$TaskType resp)
      : this(resp.id, resp.name, resp.description, resp.basePointsPrize);

  Task.fromCreateResp(CreateTask$Mutation$TaskSerializerMutation$TaskType resp)
      : this(resp.id, resp.name, resp.description, resp.basePointsPrize);
}
