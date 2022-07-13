import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../supportmessage.dart';
import 'accumlative_report_screen.dart';

class AccumlativeScreen extends StatefulWidget {
  @override
  _AccumlativeScreenState createState() => _AccumlativeScreenState();
}

class _AccumlativeScreenState extends State<AccumlativeScreen> {

  String name ='';
  String uid='';
  List <String> list=[];

  supportMessage message=new supportMessage();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    message.requestPermission();

    message.loadFCM();

    message.listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Health");

    message.sendPushMessage();
  }

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('report').snapshots();


  void actionPopUpItemSelected(String value, String name) {
    String message;
    if (value == 'report') {
      message = 'You selected edit for $name';
    }
    else {
      message = 'Not implemented';
    }
    print(message);
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            token = token;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.pink[200],
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
                  list.add(
                      snapshot.data!.docChanges[index].doc['date']
                          +'\n'+'Name: '+snapshot.data!.docChanges[index].doc['Name']
                          +'\n'+'Hair Loss: '+snapshot.data!.docChanges[index].doc['Hair_loss']
                          +'\n'+'loss of appetite: '+snapshot.data!.docChanges[index].doc['Loss_of_appetite']
                          +'\n'+'diarrhea: '+snapshot.data!.docChanges[index].doc['Diarrhea']
                          +'\n'+'vomiting: '+snapshot.data!.docChanges[index].doc['Vomiting']
                          +'\n'+'weight loss: '+snapshot.data!.docChanges[index].doc['Weight_loss']
                          +'\n'+'changes in skin: '+snapshot.data!.docChanges[index].doc['Changes_in_skin']
                          +'\n'+'ulcers in mouth: '+snapshot.data!.docChanges[index].doc['Ulcers_in_mouth']
                          +'\n'+'vaginal dryness: '+snapshot.data!.docChanges[index].doc['Vaginal_dryness']
                          +'\n'+'poor memory: '+snapshot.data!.docChanges[index].doc['Poor_memory']
                          +'\n'+'anemia: '+snapshot.data!.docChanges[index].doc['Anemia']
                          +'\n'+'nerve damage: '+snapshot.data!.docChanges[index].doc['Nerve_damage']
                  );
                  return GestureDetector(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        Material(
                          elevation: 20,
                          shadowColor: Colors.white38,
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.docChanges[index].doc['date']
                                  +'\n'+'Name: '+snapshot.data!.docChanges[index].doc['Name']
                                  +'\n'+'Hair Loss: '+snapshot.data!.docChanges[index].doc['Hair_loss']
                                  +'\n'+'loss of appetite: '+snapshot.data!.docChanges[index].doc['Loss_of_appetite']
                                  +'\n'+'diarrhea: '+snapshot.data!.docChanges[index].doc['Diarrhea']
                                  +'\n'+'vomiting: '+snapshot.data!.docChanges[index].doc['Vomiting']
                                  +'\n'+'weight loss: '+snapshot.data!.docChanges[index].doc['Weight_loss']
                                  +'\n'+'changes in skin: '+snapshot.data!.docChanges[index].doc['Changes_in_skin']
                                  +'\n'+'ulcers in mouth: '+snapshot.data!.docChanges[index].doc['Ulcers_in_mouth']
                                  +'\n'+'vaginal dryness: '+snapshot.data!.docChanges[index].doc['Vaginal_dryness']
                                  +'\n'+'poor memory: '+snapshot.data!.docChanges[index].doc['Poor_memory']
                                  +'\n'+'anemia: '+snapshot.data!.docChanges[index].doc['Anemia']
                                  +'\n'+'nerve damage: '+snapshot.data!.docChanges[index].doc['Nerve_damage'],

                            //  list[index],

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
        label: Text("Make Report"),
        //icon: Icon(Icons.add),
        backgroundColor: Colors.pink[200],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) =>AccumlativeReport(x:list) ));
        },
      ),
    );
  }
}