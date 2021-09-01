import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/providers/points_provider/Points.dart';
import 'package:home_keeper/providers/points_provider/points_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

enum PointsPeriods { Week, Month, Year }

class TeamMembers extends StatelessWidget {
  final PointsPeriods _pointsPeriod;

  TeamMembers(this._pointsPeriod);

  @override
  Widget build(BuildContext context) {
    final pointsProvider = Provider.of<PointsProvider>(context);
    final teamProvider = Provider.of<TeamProvider>(context);

    Points points;
    switch (_pointsPeriod) {
      case PointsPeriods.Week:
        points = pointsProvider.weekPoints;
        break;
      case PointsPeriods.Month:
        points = pointsProvider.monthPoints;
        break;
      case PointsPeriods.Year:
        points = pointsProvider.yearPoints;
        break;
    }

    final teamMembers = teamProvider.currentTeamInfo.teamMembers;
    return CommonContainer(
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
            children: teamMembers
                .map<ListTile>((e) => ListTile(
                        title: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: e.color,
                        ),
                        SizedBox(width: 5.0),
                        Text(e.username),
                        Spacer(),
                        pointsProvider.state ==
                                PointsProviderState.Uninitialized
                            ? Loading()
                            : Text(points.membersPoints[e.id]!.pointsSum
                                .toString())
                      ],
                    )))
                .toList(),
          ))
    ]));
  }
}
