import 'package:flutter/material.dart';
import 'package:home_keeper/pages/settings.dart';
import 'package:home_keeper/pages/tasks.dart';
import 'package:home_keeper/pages/team.dart';
import 'package:home_keeper/providers/teams_provider.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final _children = [Home(), Tasks(), Team(), Settings()];

  var _currentIndex = 0;
  var _currentType = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => TeamProvider())],
        builder: (context, child) {
          TeamProvider teamProvider = Provider.of(context);

          return FutureBuilder<bool>(
              future: teamProvider.isUserMemberOfTeam(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data) {
                    return Scaffold(
                      body: _children[_currentIndex],
                      bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: Theme.of(context).buttonColor,
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
                        currentIndex: _currentIndex,
                        onTap: _onItemTapped,
                      ),
                    );
                  } else {
                    return Scaffold(
                      body: _children[_currentIndex],
                      bottomNavigationBar: BottomNavigationBar(
                        selectedItemColor: Theme.of(context).buttonColor,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                              icon: Icon(Icons.rule_rounded), label: 'Tasks'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.settings), label: 'Settings')
                        ],
                        currentIndex: _currentIndex,
                        onTap: _onItemTapped,
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                } else {}
                return Scaffold(
                    body: Center(
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator()],
                )));
              });
        });
  }
}
