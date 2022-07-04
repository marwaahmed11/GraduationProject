import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/ui/screens/login_screen.dart';

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}

class SettingPage extends StatefulWidget {

  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Settings"),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[

                RaisedButton(
                  onPressed: () {
                    logout();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  },
                  child: Text('Log out'),
                ),
              ],
            ),
          /*  Column(
              children: <Widget>[

                RaisedButton(
                  onPressed: () {
                    logout();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => editUserScreen()));
                  },
                  child: Text('Edit your account info'),
                ),
              ],
            ),*/
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}


