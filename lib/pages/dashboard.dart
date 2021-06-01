import 'package:flutter/material.dart';
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
    with SingleTickerProviderStateMixin {
  final _children = [Home(), Tasks(), Team(), Settings()];

  TabController _controller;
  var isUserMemberOfTeam = null;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: _children.length, vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TeamProvider teamProvider = Provider.of(context);
    if (isUserMemberOfTeam == null) {
      isUserMemberOfTeam = teamProvider.isUserMemberOfTeam();
    }

    return FutureBuilder<bool>(
        future: isUserMemberOfTeam,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: TabBarView(
                  children: _children,
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
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.supervisor_account_rounded),
                        label: 'Team'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.rule_rounded), label: 'Tasks'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings')
                  ],
                ));
          } else if (snapshot.hasError) {
            throw UnsupportedError(snapshot.error.toString());
          } else {
            return Scaffold(body: Loading());
          }
        });
  }
}
