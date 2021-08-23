import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/teams_provider/team_member.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/utils/enumerate.dart';
import 'package:provider/provider.dart';

class UsersPointsPieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UsersPointsPieChartState();
}

class UsersPointsPieChartState extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final teamsProvider = Provider.of<TeamProvider>(context);

    return Container(
        child: Column(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch =
                        pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
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
                sections: showingSections(teamsProvider)),
          ),
        ),
      ],
    ));
  }

  List<PieChartSectionData> showingSections(TeamProvider teamProvider) {
    return enumerate<PieChartSectionData, TeamMember>(
        teamProvider.currentTeamInfo.teamMembers, (i, member) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
          color: member.color,
          value: 100,
          title: '33%',
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ));
    }).toList(growable: false);
  }
}
