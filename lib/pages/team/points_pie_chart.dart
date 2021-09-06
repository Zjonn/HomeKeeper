import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/points_provider/points.dart';
import 'package:home_keeper/providers/points_provider/points_provider.dart';
import 'package:home_keeper/providers/teams_provider/team_member.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/utils/enumerate.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

enum PieChartPeriods { Week, Month, Year }

class UsersPointsPieChart extends StatefulWidget {
  final PieChartPeriods period;

  UsersPointsPieChart(this.period);

  @override
  State<StatefulWidget> createState() => _UsersPointsPieChartState();
}

class _UsersPointsPieChartState extends State<UsersPointsPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final teamProvider = Provider.of<TeamProvider>(context);
    final pointsProvider = Provider.of<PointsProvider>(context);

    if (pointsProvider.state == PointsProviderState.Uninitialized) {
      return Loading();
    }

    Points points;
    switch (widget.period) {
      case PieChartPeriods.Week:
        points = pointsProvider.weekPoints;
        break;
      case PieChartPeriods.Month:
        points = pointsProvider.monthPoints;
        break;
      case PieChartPeriods.Year:
        points = pointsProvider.yearPoints;
        break;
    }

    return Container(
        child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: PieChart(
            PieChartData(
                pieTouchData:
                    PieTouchData(touchCallback: (event, pieTouchResponse) {
                  if (pieTouchResponse == null) {
                    return;
                  }
                  setState(() {
                    final desiredTouch =
                        event is! PointerExitEvent && event is! PointerUpEvent;
                    if (desiredTouch &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(
                    teamProvider.currentTeamInfo.teamMembers, points)),
          ),
        ),
      ],
    ));
  }

  List<PieChartSectionData> showingSections(
      List<TeamMember> teamMembers, Points points) {
    final membersNum = teamMembers.length;

    return enumerate<PieChartSectionData, TeamMember>(teamMembers, (i, member) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      final membersPointsSum = points.membersPointsSum;
      final memberPoints = points.membersPoints[member.id]!.pointsSum;

      final pointsPercent = membersPointsSum > 0
          ? (memberPoints / membersPointsSum) * 100
          : 100 / membersNum;
      final title =
          pointsPercent >= 1 ? '${pointsPercent.toStringAsFixed(0)}%' : '';
      final double value = membersPointsSum > 0 ? memberPoints.toDouble() : 1;

      return PieChartSectionData(
          color: member.color,
          value: value,
          title: title,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ));
    }).toList(growable: false);
  }
}
