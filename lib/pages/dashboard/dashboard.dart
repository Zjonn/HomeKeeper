import 'package:flutter/material.dart';
import 'package:home_keeper/pages/home/home.dart';
import 'package:home_keeper/pages/join_team/join_team_builder.dart';
import 'package:home_keeper/pages/settings.dart';
import 'package:home_keeper/pages/tasks/tasks_builder.dart';
import 'package:home_keeper/pages/team/team.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/points_provider/points_provider.dart';
import 'package:home_keeper/providers/sync_provider.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

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

  final _tabs = [Home(), TasksBuilder(), Team(), Settings()];
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
    final teamProvider = Provider.of<TeamProvider>(context);
    final client = Provider.of<AuthClientProvider>(context).client;

    switch (teamProvider.state) {
      case TeamProviderState.UserIsMember:
        final tabs = _tabs;
        _changeController(tabs, true);
        return MultiProvider(
            providers: [
              ChangeNotifierProxyProvider2<TeamProvider, SyncProvider,
                  TasksProvider>(
                create: (_) => TasksProvider(client),
                update: (_, teamProvider, syncProvider, previous) {
                  previous!.update(teamProvider.currentTeamInfo.id);
                  return previous;
                },
              ),
              ChangeNotifierProxyProvider3<TeamProvider, SyncProvider,
                      TasksProvider, PointsProvider>(
                  create: (_) => PointsProvider(client),
                  update:
                      (_, teamProvider, syncProvider, tasksProvider, previous) {
                    previous!.update(teamProvider.currentTeamInfo.id);
                    return previous;
                  })
            ],
            child: Scaffold(
                body: TabBarView(
                  children: tabs,
                  controller: _controller,
                ),
                bottomNavigationBar: TabBar(
                  tabs: _tabs_icons
                      .map((e) => Container(
                            margin: EdgeInsets.all(15),
                            child: Icon(e),
                          ))
                      .toList(),
                  controller: _controller,
                )));

      case TeamProviderState.UserIsNotMember:
        final tabs = _no_team_tabs;
        _changeController(tabs, false);
        return Scaffold(
            body: TabBarView(
              children: tabs,
              controller: _controller,
            ),
            bottomNavigationBar: TabBar(
              tabs: _no_team_tabs_icons
                  .map((e) => Container(
                        margin: EdgeInsets.all(15),
                        child: Icon(e),
                      ))
                  .toList(),
              controller: _controller,
            ));
      case TeamProviderState.Uninitialized:
        return Scaffold(body: Loading());
    }
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
