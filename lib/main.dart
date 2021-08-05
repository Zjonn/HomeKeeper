import 'package:flutter/material.dart';
import 'package:home_keeper/pages/dashboard/dashboard_builder.dart';
import 'package:home_keeper/pages/login.dart';
import 'package:home_keeper/pages/register.dart';
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
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        builder: (context, child) {
          final authProvider = Provider.of<AuthProvider>(context);
          return MaterialApp(
              title: 'HomeKeeper',
              theme: ThemeData.dark(),
              home: FutureBuilder<bool>(
                  future: authProvider.isTokenValid(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Loading();
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else if (!snapshot.data!)
                          return Login();
                        else {
                          return DashBoardBuilder();
                        }
                    }
                  }),
              routes: {
                '/dashboard': (context) => DashBoardBuilder(),
                '/login': (context) => Login(),
                '/register': (context) => Register(),
              });
        });
  }
}
