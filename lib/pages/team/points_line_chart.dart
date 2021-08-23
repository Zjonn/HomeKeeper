import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/teams_provider/team_member.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:provider/provider.dart';

enum LineChartPeriods { Week, Month, Year }

class UsersPointsLineChart extends StatefulWidget {
  final LineChartPeriods period;
  UsersPointsLineChart(this.period);

  @override
  State<StatefulWidget> createState() {
    switch (period) {
      case LineChartPeriods.Week:
        return _UsersPointsWeekLineChartState();
      case LineChartPeriods.Month:
        return _UsersPointsWeekLineChartState();
      case LineChartPeriods.Year:
        return _UsersPointsWeekLineChartState();
    }
  }
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
                          teamProvider.currentTeamInfo.teamMembers),
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

  LineChartData _userPointsChart(List<TeamMember> teamMembers) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return 'MON';
              case 1:
                return 'TUE';
              case 2:
                return 'WED';
              case 3:
                return 'THU';
              case 4:
                return 'FRI';
              case 5:
                return 'SAT';
              case 6:
                return 'SUN';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
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
      minX: 0,
      maxX: 7,
      minY: 0,
      lineBarsData: userPointsData(teamMembers),
    );
  }

  List<LineChartBarData> userPointsData(List<TeamMember> teamMembers) {
    return teamMembers
        .map<LineChartBarData>((e) => LineChartBarData(
              spots: [
                FlSpot(0, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(1, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(2, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(3, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(4, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(5, (Random().nextDouble() * 10).truncateToDouble()),
                FlSpot(6, (Random().nextDouble() * 10).truncateToDouble()),
              ],
              isCurved: true,
              curveSmoothness: 0.3,
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
