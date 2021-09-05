import 'package:flutter/material.dart';
import 'package:home_keeper/pages/authentication/authentication_builder.dart';
import 'package:home_keeper/pages/dashboard/dashboard_builder.dart';
import 'package:home_keeper/pages/no_connection.dart';
import 'package:home_keeper/providers/auth_provider/auth_provider.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ConnectionProvider(),
        builder: (context, child) {
          return MaterialApp(
            title: 'HomeKeeper',
            theme: ThemeData.dark(),
            home: Builder(builder: (context) {
              final connectionProvider =
                  Provider.of<ConnectionProvider>(context);

              switch (connectionProvider.state) {
                case ConnectionProviderState.CheckInProgress:
                  return Loading();
                case ConnectionProviderState.NoBackendConnection:
                  return NoConnection(
                      'Server is in sleeping mode or is under maintenance. '
                      'Please try again in a minute 😓');
                case ConnectionProviderState.NoInternetConnection:
                  return NoConnection('No internet connection 😢');
                case ConnectionProviderState.Connected:
                  return ChangeNotifierProvider(
                      create: (value) => AuthProvider(connectionProvider),
                      builder: (BuildContext context, _) {
                        final authProvider = Provider.of<AuthProvider>(context);

                        switch (authProvider.loggedInStatus) {
                          case Status.Uninitialized:
                            return Loading();
                          case Status.NotLoggedIn:
                          case Status.Authenticating:
                          case Status.LoggedOut:
                            return AuthenticationBuilder();
                          case Status.LoggedIn:
                            return DashBoardBuilder();
                          default:
                            return Text(
                                'Error: ${authProvider.loggedInStatus}');
                        }
                      });
              }
            }),
          );
        });
  }
}
