import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/main.dart';
import 'package:project/ui/report/prediction.dart';

import 'accumlative_report_screen.dart';

class AccumlativeScreen extends StatefulWidget {
  @override
  _AccumlativeScreenState createState() => _AccumlativeScreenState();
}

class _AccumlativeScreenState extends State<AccumlativeScreen> {

  String name ='';
  String uid='';
  List <String>x=[];
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


  void actionPopUpItemSelected(String value, String name) {
    String message;
    if (value == 'report') {
      message = 'You selected edit for $name';
      /* Navigator.push(
        context,
        MaterialPageRoute(
          //builder: (_) => AccumulatorScreen(),
        ),
      );*/
    }
    else {
      message = 'Not implemented';
    }
    print(message);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.pink[200],
      /*  actions: [
          MaterialButton(
            color: Colors.pink[200],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>AccumlativeReport(x:x)
                ),
              );
            },
            child: Text(
              "Make Report",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          )
        ],*/
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
                  x.add(
                      snapshot.data!.docChanges[index].doc['date']
                          +'\n'+'Hair Loss: '+snapshot.data!.docChanges[index].doc['question1']
                          +'\n'+'loss of appetite: '+snapshot.data!.docChanges[index].doc['question2']
                          +'\n'+'diarrhea: '+snapshot.data!.docChanges[index].doc['question3']
                          +'\n'+'vomiting: '+snapshot.data!.docChanges[index].doc['question4']
                          +'\n'+'weight loss: '+snapshot.data!.docChanges[index].doc['question5']
                          +'\n'+'changes in skin: '+snapshot.data!.docChanges[index].doc['question6']
                          +'\n'+'ulcers in mouth: '+snapshot.data!.docChanges[index].doc['question7']
                          +'\n'+'vaginal dryness: '+snapshot.data!.docChanges[index].doc['question8']
                          +'\n'+'poor memory: '+snapshot.data!.docChanges[index].doc['question9']
                          +'\n'+'anemia: '+snapshot.data!.docChanges[index].doc['question10']
                          +'\n'+'nerve damage: '+snapshot.data!.docChanges[index].doc['question11']
                  );
                  print("helloooooooooooooooo");
                  return GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Material(
                          //padding: const EdgeInsets.all(8.0),
                          elevation: 20,
                          shadowColor: Colors.white38,
                         /* padding: EdgeInsets.only(
                            left: 3,
                            right: 3,
                          ),*/
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docChanges[index].doc['date']
                                  +'\n'+'Hair Loss: '+snapshot.data!.docChanges[index].doc['question1']
                                  +'\n'+'loss of appetite: '+snapshot.data!.docChanges[index].doc['question2']
                                  +'\n'+'diarrhea: '+snapshot.data!.docChanges[index].doc['question3']
                                  +'\n'+'vomiting: '+snapshot.data!.docChanges[index].doc['question4']
                                  +'\n'+'weight loss: '+snapshot.data!.docChanges[index].doc['question5']
                                  +'\n'+'changes in skin: '+snapshot.data!.docChanges[index].doc['question6']
                                  +'\n'+'ulcers in mouth: '+snapshot.data!.docChanges[index].doc['question7']
                                  +'\n'+'vaginal dryness: '+snapshot.data!.docChanges[index].doc['question8']
                                  +'\n'+'poor memory: '+snapshot.data!.docChanges[index].doc['question9']
                                  +'\n'+'anemia: '+snapshot.data!.docChanges[index].doc['question10']
                                  +'\n'+'nerve damage: '+snapshot.data!.docChanges[index].doc['question11'],

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
      floatingActionButton: FloatingActionButton.extended(

        //  HomeScreen(),
        label: Text("Make Report"),
        //icon: Icon(Icons.add),
        backgroundColor: Colors.pink[200],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) =>AccumlativeReport(x:x) ));
        },
      ),

    );
  }
}