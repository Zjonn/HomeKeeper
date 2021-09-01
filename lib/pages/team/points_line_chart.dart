import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/points_provider/Points.dart';
import 'package:home_keeper/providers/points_provider/points_provider.dart';
import 'package:home_keeper/providers/teams_provider/team_member.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/utils/enumerate.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

enum LineChartPeriods { Week, Month, Year }

class UsersPointsLineChart extends StatefulWidget {
  final LineChartPeriods period;
  UsersPointsLineChart(this.period);

  @override
  State<StatefulWidget> createState() => _UsersPointsWeekLineChartState();
}

class _UsersPointsWeekLineChartState extends State<UsersPointsLineChart> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    TeamProvider teamProvider = Provider.of<TeamProvider>(context);
    PointsProvider pointsProvider = Provider.of<PointsProvider>(context);

    if (pointsProvider.state == PointsProviderState.Uninitialized) {
      return Loading();
    }

    Points points;
    switch (widget.period) {
      case LineChartPeriods.Week:
        points = pointsProvider.weekPoints;
        break;
      case LineChartPeriods.Month:
        points = pointsProvider.monthPoints;
        break;
      case LineChartPeriods.Year:
        points = pointsProvider.yearPoints;
        break;
    }

    return Container(
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      _userPointsChart(
                          teamProvider.currentTeamInfo.teamMembers, points),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _userPointsChart(List<TeamMember> teamMembers, Points points) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (_, value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          margin: 10,
          getTitles: (value) {
            return value.toInt() < points.pointsDescription.length
                ? points.pointsDescription[value.toInt()]
                : '';
          },
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (_, value) => const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minY: 0,
      maxY: points.membersPointsSum > 0 ? null : 10,
      lineBarsData: userPointsData(teamMembers, points),
    );
  }

  List<LineChartBarData> userPointsData(
      List<TeamMember> teamMembers, Points points) {
    return teamMembers
        .map<LineChartBarData>((e) => LineChartBarData(
              spots: enumerate<FlSpot, int>(points.membersPoints[e.id]!.points,
                      (i, v) => FlSpot(i.toDouble(), v.toDouble()))
                  .toList(growable: false),
              isCurved: true,
              preventCurveOverShooting: true,
              curveSmoothness: 0.5,
              colors: [
                e.color,
              ],
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
              ),
              belowBarData: BarAreaData(
                show: false,
              ),
            ))
        .toList(growable: false);
  }
}
