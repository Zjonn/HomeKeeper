import 'package:flutter/material.dart';
import 'package:home_keeper/pages/authentication/authentication_builder.dart';
import 'package:home_keeper/pages/dashboard/dashboard_builder.dart';
import 'package:home_keeper/pages/authentication/login.dart';
import 'package:home_keeper/providers/api_url_provider.dart';
import 'package:home_keeper/providers/auth_provider.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ApiUrlProvider()),
          ChangeNotifierProxyProvider<ApiUrlProvider, AuthProvider>(
            create: (value) => AuthProvider(ApiUrlProvider.initialApiUrl),
            update: (context, value, previous) => AuthProvider(value.apiUrl),
          ),
        ],
        builder: (context, child) {
          final authProvider = Provider.of<AuthProvider>(context);
          return MaterialApp(
            title: 'HomeKeeper',
            theme: ThemeData.dark(),
            home: Builder(builder: (context) {
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
                  return Text('Error: ${authProvider.loggedInStatus}');
              }
            }),
          );
        });
  }
}
