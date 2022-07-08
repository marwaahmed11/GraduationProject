import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../supportmessage.dart';
import '../screens/event_screen.dart';

class showevent extends StatefulWidget {
  DocumentSnapshot docid;
  String uid;
  showevent({required this.docid,required this.uid});

  @override
  _showeventState createState() => _showeventState(docid: docid,uid:uid);
}

class _showeventState extends State<showevent> {
  DocumentSnapshot docid;
  String uid;
  _showeventState({required this.docid,required this.uid});


  String name='';
  String subject1 ='';
  String date='';

  supportMessage message=new supportMessage();

  @override
  void initState() {
    date=widget.docid.get('selectedDay');
    name = widget.docid.get('eventname');
    subject1 =  widget.docid.get('eventdesc');

    super.initState();

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


  @override
  Widget build(BuildContext context) {
    int group =1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show Event",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 251, 251, 251),
          ),
        ),
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ListEventScreen()));

          },
        ),
        automaticallyImplyLeading: false,
        actions: [
           MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ListEventScreen()));
              });
            },
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Event date: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),),
                child: Text(
                  date,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),

              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child: Text(
                  'Event Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),

              Container(
                child:  Text("Event Description ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );



  }
}
