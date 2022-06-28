import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../mainscreen.dart';

class MyHomePage extends StatefulWidget {
//MyHomePage({required Key key, required this.title}) : super(key: key);
MyHomePage({Key? key, required this.title}) : super(key: key);
final String title;
@override
_MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainScreen ms = new MainScreen();
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Email"),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[

                RaisedButton(
                  onPressed: () {
                    customLaunch('mailto:your@email.com?subject=test%20subject&body=test%20body');
                  },
                  child: Text('Email'),
                ),
                RaisedButton(
                  onPressed: () {
                    customLaunch('sms:');
                  },
                  child: Text('SMS'),
                ),
              ],
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
