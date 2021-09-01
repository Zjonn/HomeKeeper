import 'package:home_keeper/graphql/graphql_api.dart';

class Task {
  final String id;
  final String name;
  final String description;

  final String? _period;
  final bool isPeriodic;
  final int points;

  int? get period => _period == null
      ? null
      : int.parse(RegExp(r'(\d+) day.*').firstMatch(_period!)!.group(1)!) ~/
          (24.0 * 60 * 60);

  Task(this.id, this.name, this.description, this.points, this.isPeriodic,
      this._period);

  Task.fromCreateResp(CreateTask$Mutation$TaskSerializerMutation$TaskType resp)
      : this(resp.id, resp.name, resp.description, resp.basePointsPrize,
            resp.isRecurring, resp.refreshInterval);
}
