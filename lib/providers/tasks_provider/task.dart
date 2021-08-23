import 'package:home_keeper/graphql/graphql_api.dart';

class Task {
  final String id;
  final String name;
  final String description;

  final int points;

  Task(this.id, this.name, this.description, this.points);

  Task.fromResp(ListTasks$Query$TaskType resp)
      : this(resp.id, resp.name, resp.description, resp.basePointsPrize);

  Task.fromCreateResp(CreateTask$Mutation$TaskSerializerMutation$TaskType resp)
      : this(resp.id, resp.name, resp.description, resp.basePointsPrize);
}
