import 'package:flutter/cupertino.dart';
import 'package:home_keeper/pages/dashboard/dashboard.dart';
import 'package:home_keeper/providers/api_url_provider.dart';
import 'package:home_keeper/providers/auth_client_provider.dart';
import 'package:home_keeper/providers/points_provider/points_provider.dart';
import 'package:home_keeper/providers/tasks_provider/tasks_provider.dart';
import 'package:home_keeper/providers/teams_provider/teams_provider.dart';
import 'package:home_keeper/widgets/loading.dart';
import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<ApiURLProvider, AuthClientProvider>(
        create: (_) => AuthClientProvider(ApiURLProvider.defaultApiURL),
        update: (context, value, previous) => AuthClientProvider(value.apiURL),
        builder: (context, child) {
          final client = Provider.of<AuthClientProvider>(context);

          if (client.state == AuthClientProviderState.InProgress) {
            return Loading();
          }
          return MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => TeamProvider(client.client)),
            ChangeNotifierProxyProvider<TeamProvider, TasksProvider>(
              create: (_) => TasksProvider(client.client),
              update: (_, teamProvider, previous) {
                previous!.update(teamProvider.currentTeamInfo.id);
                return previous;
              },
            ),
            ChangeNotifierProxyProvider2<TeamProvider, TasksProvider,
                    PointsProvider>(
                create: (_) => PointsProvider(client.client),
                update: (_, teamProvider, tasksProvider, previous) {
                  previous!.update(teamProvider.currentTeamInfo.id);
                  return previous;
                })
          ], builder: (context, child) => DashBoard());
        });
  }
}
