import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/ui/authentication/login_screen.dart';

import '../settings/edituser_screen.dart';

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

  String uid='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }



  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.pink[200],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('settings')));
            },
          ),

        ],
      ),
     /* body: Center(
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
              /*  IconButton(
                  icon: const Icon(Icons.login_outlined),
                  onPressed: () {},
                ),*/

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
      ),*/
      body: StreamBuilder(


        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (_, index) {
                if (snapshot.data!.docs[index].get('uid') == uid) {
                  print("helloooooooooooooooo");
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              editUserScreen(
                                  docid: snapshot.data!.docs[index],
                                  uid: uid),
                        ),
                      );
                    },
                    child: Column(
                      children: [

                        SizedBox(
                          height: 4,
                        ),
                        Material(
                         /* padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),*/
                            elevation: 20,
                            shadowColor: Colors.white38,
                          child: ListTile(
                           /* trailing: const Text(
                              "Report",
                              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                            ),*/
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                             "Manage your Account",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                          ),

                        ),
                       /* RaisedButton(
                          onPressed: () {
                            logout();
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_) => LoginScreen()));
                          },
                          child: Text('Log out',
                          textAlign: TextAlign.center,
                          ),
                        ),*/
                      ],
                    ),
                  );
                }//if
                else{
                  return GestureDetector(
                    child: Column(
                      children: [
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

          logout();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
      //  icon: const Icon(Icons.logout),
        backgroundColor: Colors.pink[200],
      ),



      // This trailing comma makes auto-formatting nicer for build methods.
    );

  }


}


