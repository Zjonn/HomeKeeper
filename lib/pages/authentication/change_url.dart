import 'package:flutter/material.dart';
import 'package:home_keeper/providers/api_url_provider.dart';
import 'package:home_keeper/widgets/button.dart';
import 'package:home_keeper/widgets/flushbar.dart';
import 'package:provider/provider.dart';

class ChangeURL extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangeURLState();
}

class _ChangeURLState extends State<ChangeURL> {
  final _myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urlProvider = Provider.of<ApiURLProvider>(context);

    var changeURL = () {
      urlProvider.apiURL = _myController.text;
      CommonFlushbar("URL changed").show(context);
      ;
    };

    var restoreURL = () {
      urlProvider.apiURL = ApiURLProvider.initialApiURL;
      CommonFlushbar("URL restored").show(context);
      ;
    };

    _myController.text = urlProvider.apiURL;

    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _myController,
                ),
                SizedBox(height: 5.0),
                CommonMaterialButton(
                  "Change URL",
                  onPressed: changeURL,
                ),
                SizedBox(height: 5.0),
                CommonMaterialButton(
                  "Restore default",
                  onPressed: restoreURL,
                )
              ],
            )));
  }
}
