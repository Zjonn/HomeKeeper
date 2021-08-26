import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/pages/team/points_line_chart.dart';
import 'package:home_keeper/pages/team/points_pie_chart.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class Team extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Team();
}

class _Team extends State<Team> with AutomaticKeepAliveClientMixin<Team> {
  int _setPeriod = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final teamProvider = Provider.of<TeamProvider>(context);
    final teamInfo = teamProvider.currentTeamInfo;

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

    final teamMembers = CommonContainer(
        child: Column(children: [
      Text(
        "Members",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
      Container(
          constraints: new BoxConstraints(maxHeight: 200),
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: teamInfo.teamMembers
                .map((e) => ListTile(
                        title: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: e.color,
                        ),
                        SizedBox(width: 5.0),
                        Text(e.username)
                      ],
                    )))
                .toList(),
          ))
    ]));

    final timePeriod = CommonContainer(
      child: Column(children: [
        SizedBox(height: 5.0),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).backgroundColor),
                borderRadius: BorderRadius.circular(40)),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 1,
                    child: CommonMaterialButton(
                      'Week',
                      onPressed: () => {
                        setState(() {
                          _setPeriod = 0;
                        })
                      },
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40)),
                      textColor: _setPeriod == 0
                          ? Theme.of(context).accentColor
                          : null,
                    )),
                Expanded(
                  flex: 1,
                  child: CommonMaterialButton(
                    'Month',
                    onPressed: () => {
                      setState(() {
                        _setPeriod = 1;
                      })
                    },
                    borderRadius: BorderRadius.zero,
                    textColor:
                        _setPeriod == 1 ? Theme.of(context).accentColor : null,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: CommonMaterialButton(
                      'Year',
                      onPressed: () => {
                        setState(() {
                          _setPeriod = 2;
                        })
                      },
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      textColor: _setPeriod == 2
                          ? Theme.of(context).accentColor
                          : null,
                    )),
              ],
            ))
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
                _getCharts(),
                SizedBox(height: 5.0),
                timePeriod,
                SizedBox(height: 5.0),
                teamMembers,
              ]),
        ));
  }

  @override
  bool get wantKeepAlive => true;

  CommonContainer _getCharts() {
    var pieChartPeriod;
    var lineChartPeriod;

    switch (_setPeriod) {
      case 1:
        pieChartPeriod = PieChartPeriods.Month;
        lineChartPeriod = LineChartPeriods.Month;
        break;
      case 2:
        pieChartPeriod = PieChartPeriods.Year;
        lineChartPeriod = LineChartPeriods.Year;
        break;
      case 0:
      default:
        pieChartPeriod = PieChartPeriods.Week;
        lineChartPeriod = LineChartPeriods.Week;
        break;
    }

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
}
