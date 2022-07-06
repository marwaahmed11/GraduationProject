import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/main.dart';
import 'package:project/ui/report/prediction.dart';
import '../report/addreport.dart';
import '../report/showreport.dart';
import '../history/accumlative_screen.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {

  String name ='';
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
  FirebaseFirestore.instance.collection('report').snapshots();


  /*void actionPopUpItemSelected(String value, String name) {
    String message;
    if (value == 'report') {
      message = 'You selected edit for $name';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AccumlativeScreen (),
        ),
      );
    }
else {
      message = 'Not implemented';
    }
    print(message);
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addreport(uid:uid)));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.pink[200],
      ),
      appBar: AppBar(
        title: Text('Reports'),
          backgroundColor: Colors.pink[200],
          actions: [
           /* PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'report',
                    child: Text('Accumlative Report'),
                  ),
                ];
              },
              onSelected: (String value){
                print('You Click on po up menu item');
                actionPopUpItemSelected(value,name);
              },
            ),*/
          ]


      ),
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
                              showreport(docid: snapshot.data!.docs[index],uid:uid),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                       /* Padding(
                          padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),*/
                        Material(
                            //padding: const EdgeInsets.all(8.0),
                            elevation: 20,
                            shadowColor: Colors.white38,
                          child: ListTile(
                        ////////////////////////////////////////////////////////hna
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docChanges[index].doc['date'],
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
    );
  }
}

