import 'package:artemis/artemis.dart';
import 'package:flutter/cupertino.dart';
import 'package:home_keeper/graphql/graphql_api.dart';
import 'package:home_keeper/utils/pair.dart';
import 'package:intl/intl.dart';

class Points {
  final Map<String, MemberPoints> membersPoints;
  final List<String> pointsDescription;
  late final int membersPointsSum;

  Points(this.membersPoints, this.pointsDescription) {
    membersPointsSum =
        membersPoints.values.map((e) => e.pointsSum).fold(0, (v, e) => v + e);
  }
}

class MemberPoints {
  final String userId;
  final List<int> points;
  late final int pointsSum;

  MemberPoints(this.userId, this.points) {
    pointsSum = points.fold(0, (v, e) => v + e);
  }
}

enum PointsProviderState { Initialized, Uninitialized }

class PointsProvider extends ChangeNotifier {
  final ArtemisClient _client;
  PointsProviderState _state = PointsProviderState.Uninitialized;

  Points _week = Points({}, []);
  Points _month = Points({}, []);
  Points _year = Points({}, []);

  Points get weekPoints => _week;

  Points get monthPoints => _month;

  Points get yearPoints => _year;

  get state => _state;

  PointsProvider(this._client);

  void update(String teamId) async {
    var periodsPoints = await Future.wait([
      _getWeekPoints(teamId),
      _getMonthPoints(teamId),
      _getYearPoints(teamId)
    ]);

    _week = periodsPoints[0];
    _month = periodsPoints[1];
    _year = periodsPoints[2];

    if (_state == PointsProviderState.Uninitialized) {
      _state = PointsProviderState.Initialized;
    }

    notifyListeners();
  }

  Future<Points> _getWeekPoints(String teamId) async {
    return _getDurationPoints(teamId, Duration(days: 1), 7, DateFormat.E());
  }

  Future<Points> _getMonthPoints(String teamId) async {
    return _getDurationPoints(teamId, Duration(days: 7), 5, DateFormat.MMMd());
  }

  Future<Points> _getYearPoints(String teamId) async {
    return _getDurationPoints(teamId, Duration(days: 60), 6, DateFormat.MMM());
  }

  Future<Points> _getDurationPoints(String teamId, Duration periodDuration,
      int periods, DateFormat format) async {
    final now = DateTime.now();

    var currentDay = DateTime.now()
        .subtract(Duration(
          hours: now.hour,
          minutes: now.minute,
          seconds: now.second,
          microseconds: now.microsecond,
          milliseconds: now.millisecond,
        ))
        .subtract(Duration(milliseconds: 100))
        .subtract(periodDuration - Duration(days: 1));

    var futurePoints = [_getPoints(teamId, currentDay, now)];
    var description = [format.format(now)];
    for (var i = 0; i < periods - 1; i++) {
      var prevDay = currentDay.subtract(periodDuration);

      futurePoints.add(_getPoints(teamId, prevDay, currentDay));
      description.add(format.format(currentDay));

      currentDay = prevDay;
    }

    var points = await Future.wait(futurePoints);
    var membersPoints = <String, MemberPoints>{};
    for (var i = 0; i < points[0].length; i++) {
      var memberId = points[0][i].a;
      var memberPoints =
          [for (var x in points) x[i].b].reversed.toList(growable: false);
      membersPoints[memberId] = MemberPoints(memberId, memberPoints);
    }

    return Points(membersPoints, description.reversed.toList(growable: false));
  }

  Future<List<Pair<String, int>>> _getPoints(
      String teamId, DateTime from, DateTime to) async {
    GraphQLResponse<TeamMembersPoints$Query> response = await _client.execute(
        TeamMembersPointsQuery(
            variables: TeamMembersPointsArguments(
                teamId: int.parse(teamId),
                fromDateTime: from.toUtc(),
                toDateTime: to.toUtc())));

    assert(!response.hasErrors);
    return response.data!.teamMembersPoints!
        .map((e) => Pair(e!.member!.id, e.points!))
        .toList(growable: false);
  }
}
