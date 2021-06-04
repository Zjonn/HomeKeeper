import 'package:flutter/material.dart';
import 'package:home_keeper/pages/join_team/join_team_builder.dart';
import 'package:home_keeper/pages/settings.dart';
import 'package:home_keeper/pages/tasks.dart';
import 'package:home_keeper/pages/team.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with TickerProviderStateMixin<DashBoard> {
  final _no_team_tabs = [JoinTeamBuilder(), Settings()];
  final _no_team_tabs_icons = [
    Icons.supervisor_account_rounded,
    Icons.settings
  ];

  final _tabs = [Home(), Tasks(), Team(), Settings()];
  final _tabs_icons = [
    Icons.home,
    Icons.rule_rounded,
    Icons.supervisor_account_rounded,
    Icons.settings
  ];

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TeamProvider())
        ],
        builder: (context, child) {
          final teamProvider = Provider.of<TeamProvider>(context);

          List<StatefulWidget> tabs;
          List<IconData> icons;

          switch (teamProvider.state) {
            case TeamState.CheckInProgress:
              return Scaffold(body: Loading());
            case TeamState.ToBeChecked:
              return FutureBuilder(
                  future: teamProvider.isUserMemberOfTeam(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasError) {
                      throw UnsupportedError(snapshot.error.toString());
                    }
                    return Scaffold(body: Loading());
                  });
            case TeamState.UserIsMember:
              tabs = _tabs;
              icons = _tabs_icons;
              _changeController(tabs, true);
              break;
            case TeamState.UserIsNotMember:
              tabs = _no_team_tabs;
              icons = _no_team_tabs_icons;
              _changeController(tabs, false);
              break;
          }
          return Scaffold(
              body: TabBarView(
                children: tabs,
                controller: _controller,
              ),
              bottomNavigationBar: TabBar(
                tabs: icons
                    .map((e) => Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(
                          e,
                        )))
                    .toList(),
                controller: _controller,
              ));
        });
  }

  void _changeController(final List<StatefulWidget> tabs, isUserMemberOfTeam) {
    if (_controller.length == tabs.length) {
      return;
    }
    _controller.dispose();

    _controller = new TabController(
        length: isUserMemberOfTeam ? _tabs.length : _no_team_tabs.length,
        vsync: this);
  }
}
