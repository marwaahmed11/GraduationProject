import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../supportmessage.dart';
import '../helper/addhelper.dart';
import '../helper/edithelper.dart';
import 'package:flutter/material.dart';

class HelperScreen extends StatefulWidget {
  HelperScreen();
  @override
  _HelperScreenState createState() => _HelperScreenState();
}

class _HelperScreenState extends State<HelperScreen> {


  _HelperScreenState();
  String uid='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;
  }

  supportMessage message=new supportMessage();

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

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            token = token;
          });
        }

    );
  }

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('helpers').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[200],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => addhelper(uid:uid)));
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Helpers'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.directions_run  ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a helper')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.emergency_rounded ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Emergency')));
            },
          ),
        ],
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
                                    edithelper(
                                        docid: snapshot.data!.docs[index],
                                        uid: uid),
                              ),
                            );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4,
                            width: double.infinity,
                          ),
                          Material(
                            elevation: 20,
                            shadowColor: Colors.white38,
                            child: ListTile(
                              leading:Icon(Icons.account_circle_sharp) ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                snapshot.data!.docChanges[index].doc['firstname'],
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






























