import 'package:flutter/material.dart';
import 'package:home_keeper/pages/authentication/change_url.dart';
import 'package:home_keeper/pages/authentication/login.dart';
import 'package:home_keeper/pages/authentication/register.dart';

class AuthenticationBuilder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthenticationBuilderState();
}

class _AuthenticationBuilderState extends State<AuthenticationBuilder> {
  final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async =>
            await navigatorState.currentState!.maybePop() && false,
        child: Navigator(
          key: navigatorState,
          initialRoute: 'login',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case 'login':
                return MaterialPageRoute(
                    builder: (context) => Login(), settings: settings);
              case 'register':
                return MaterialPageRoute(
                    builder: (context) => Register(), settings: settings);
              case 'url':
                return MaterialPageRoute(
                    builder: (context) => ChangeURL(), settings: settings);
              default:
                throw Exception("Invalid route");
            }
          },
        ));
  }
}
