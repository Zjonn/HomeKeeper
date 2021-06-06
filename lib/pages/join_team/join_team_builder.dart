import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/pages/join_team/create_team.dart';

import 'join_team.dart';

class JoinTeamBuilder extends StatefulWidget {
  @override
  _JoinTeamBuilder createState() => _JoinTeamBuilder();

  @override
  String toString({DiagnosticLevel? minLevel}) {
    return "Team";
  }
}

class _JoinTeamBuilder extends State<JoinTeamBuilder>
    with AutomaticKeepAliveClientMixin<JoinTeamBuilder> {
  final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
        onWillPop: () async =>
            await navigatorState.currentState!.maybePop() && false,
        child: Navigator(
          key: navigatorState,
          initialRoute: 'join_team',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case 'join_team':
                return MaterialPageRoute(
                    builder: (context) => JoinTeam(), settings: settings);
              case 'create_team':
                return MaterialPageRoute(
                    builder: (context) => CreateTeam(), settings: settings);
              default:
                throw Exception("Invalid route");
            }
          },
        ));
  }
}
