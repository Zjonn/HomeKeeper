import 'package:flutter/material.dart';
import 'package:home_keeper/pages/join_team.dart' as joinTeam;
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

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  final _no_team_tabs = [joinTeam.Team(), Settings()];
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

  TabController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TeamProvider teamProvider = Provider.of(context);

    return FutureBuilder<bool>(
        future: teamProvider.isUserMemberOfTeam(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            final tabs = snapshot.data ? _tabs : _no_team_tabs;
            final icons = snapshot.data ? _tabs_icons : _no_team_tabs_icons;

            _changeController(tabs, snapshot.data);

            return Scaffold(
                body: TabBarView(
                  children: tabs,
                  controller: _controller,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _controller.index,
                  selectedItemColor: Theme.of(context).buttonColor,
                  onTap: (int index) {
                    setState(() {
                      _controller.index = index;
                    });
                  },
                  items: _bottomNavigationBarItems(tabs, icons),
                ));
          } else if (snapshot.hasError) {
            throw UnsupportedError(snapshot.error.toString());
          } else {
            return Scaffold(body: Loading());
          }
        });
  }

  void _changeController(tabs, isUserMemberOfTeam) {
    if (_controller != null) {
      if (_controller.length == tabs.length) {
        return;
      }
      _controller.dispose();
    }

    _controller = new TabController(
        length: isUserMemberOfTeam ? _tabs.length : _no_team_tabs.length,
        vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) setState(() {});
    });
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems(
      var pages, var icons) {
    final _pages = pages.iterator;
    final _icons = icons.iterator;
    List<BottomNavigationBarItem> items = [];

    while (_pages.moveNext() && _icons.moveNext()) {
      items.add(BottomNavigationBarItem(
          icon: Icon(_icons.current), label: _pages.current.toString()));
    }
    return items;
  }
}
