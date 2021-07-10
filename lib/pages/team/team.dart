import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class Team extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Team();
}

class _Team extends State<Team> with AutomaticKeepAliveClientMixin<Team> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final teamProvider = Provider.of<TeamProvider>(context);
    final teamInfo = teamProvider.currentTeamInfo;

    final teamMembersPoints = IntrinsicHeight(
        child: PieChart(
      PieChartData(
        centerSpaceRadius: 40,
        sectionsSpace: 0,
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
      // Optional
    ));

    final currentTeam = CommonContainer(
      child: Column(children: [
        Text(
          "Current team:",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Text(teamInfo.name,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 30, color: Theme.of(context).accentColor)),
      ]),
    );

    final teamMembers = CommonContainer(
        child: Column(children: [
      Text(
        "Team members:",
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
                    title: Text(e,
                        style:
                            TextStyle(color: Theme.of(context).accentColor))))
                .toList(),
          ))
    ]));

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            teamMembersPoints,
            SizedBox(height: 5.0),
            currentTeam,
            SizedBox(height: 5.0),
            teamMembers
          ]),
      reverse: true,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
