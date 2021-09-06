import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_keeper/pages/authentication/change_url.dart';
import 'package:home_keeper/providers/connection_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/container.dart';
import 'package:provider/provider.dart';

class NoConnection extends StatelessWidget {
  final String problemDescription;

  NoConnection(this.problemDescription);

  @override
  Widget build(BuildContext context) {
    ConnectionProvider provider = Provider.of<ConnectionProvider>(context);

    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(5, 40, 5, 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CommonContainer(
                child: Center(
                    child: Text(
                  problemDescription,
                  textAlign: TextAlign.center,
                )),
              ),
              SizedBox(
                height: 5,
              ),
              CommonMaterialButton(
                "Refresh",
                onPressed: () async => await provider.updateState(),
              ),
              SizedBox(
                height: 5,
              ),
              CommonMaterialButton(
                "Change URL",
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeURL(),
                  ),
                ),
              )
            ])));
  }
}
