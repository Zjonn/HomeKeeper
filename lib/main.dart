import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home_keeper/pages/dashboard/dashboard_builder.dart';
import 'package:home_keeper/pages/login.dart';
import 'package:home_keeper/pages/register.dart';
import 'package:home_keeper/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _storage = FlutterSecureStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
          title: 'HomeKeeper',
          theme: ThemeData.dark(),
          home: FutureBuilder(
              future: _storage.read(key: "token"),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('None');
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else if (snapshot.data == null)
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
          }),
    );
  }
}
