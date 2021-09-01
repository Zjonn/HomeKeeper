import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/pages/team/members.dart';
import 'package:home_keeper/pages/team/points_line_chart.dart';
import 'package:home_keeper/pages/team/points_pie_chart.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/utils/enumerate.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

enum _Periods { Week, Month, Year }

class Team extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Team();
}

class _Team extends State<Team> with AutomaticKeepAliveClientMixin<Team> {
  _Periods _setPeriod = _Periods.Week;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final teamInfo = Provider.of<TeamProvider>(context).currentTeamInfo;

    var pieChartPeriod, lineChartPeriod, pointsPeriod;
    switch (_setPeriod) {
      case _Periods.Month:
        pieChartPeriod = PieChartPeriods.Month;
        lineChartPeriod = LineChartPeriods.Month;
        pointsPeriod = PointsPeriods.Month;
        break;
      case _Periods.Year:
        pieChartPeriod = PieChartPeriods.Year;
        lineChartPeriod = LineChartPeriods.Year;
        pointsPeriod = PointsPeriods.Year;
        break;
      case _Periods.Week:
      default:
        pieChartPeriod = PieChartPeriods.Week;
        lineChartPeriod = LineChartPeriods.Week;
        pointsPeriod = PointsPeriods.Week;
        break;
    }

    final currentTeam = CommonContainer(
      child: Column(children: [
        Text(
          "Team",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Flex(direction: Axis.horizontal, children: [
          Expanded(
              flex: 1,
              child: RichText(
                  text: TextSpan(
                text: 'Name: ',
                children: [
                  TextSpan(
                      text: teamInfo.name,
                      style: TextStyle(
                          fontSize: 30, color: Theme.of(context).accentColor)),
                ],
              ))),
          Expanded(
              flex: 1,
              child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    text: 'ID: ',
                    children: [
                      TextSpan(
                          text: teamInfo.id,
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).accentColor)),
                    ],
                  ))),
        ])
      ]),
    );

    return Container(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                currentTeam,
                SizedBox(height: 5.0),
                _getCharts(pieChartPeriod, lineChartPeriod),
                SizedBox(height: 5.0),
                _getTimePeriodPicker(),
                SizedBox(height: 5.0),
                TeamMembers(pointsPeriod),
              ]),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  CommonContainer _getCharts(var pieChartPeriod, var lineChartPeriod) {
    return CommonContainer(
      child: Column(
        children: [
          Text(
            'Points',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          UsersPointsPieChart(pieChartPeriod),
          Divider(),
          UsersPointsLineChart(lineChartPeriod),
        ],
      ),
    );
  }

  CommonContainer _getTimePeriodPicker() {
    final periods = ['Week', 'Month', 'Year'];
    final bordersRadius = [
      BorderRadius.only(
          topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
      BorderRadius.zero,
      BorderRadius.only(
          topRight: Radius.circular(40), bottomRight: Radius.circular(40))
    ];

    return CommonContainer(
      child: Column(children: [
        SizedBox(height: 5.0),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).backgroundColor),
                borderRadius: BorderRadius.circular(40)),
            child: Flex(
                direction: Axis.horizontal,
                children: enumerate<Widget, String>(
                    periods,
                    (i, v) => Expanded(
                        flex: 1,
                        child: CommonMaterialButton(
                          v,
                          onPressed: () => {
                            setState(() {
                              _setPeriod = _Periods.values[i];
                            })
                          },
                          borderRadius: bordersRadius[i],
                          textColor: _setPeriod == _Periods.values[i]
                              ? Theme.of(context).accentColor
                              : null,
                        ))).toList(growable: false)))
      ]),
    );
  }
}
