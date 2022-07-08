import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../supportmessage.dart';
import '../screens/event_screen.dart';
import 'event_screen.dart';

class addevent extends StatefulWidget {

  String uid;
  DateTime selectedDay;
  addevent({required this.uid,required this.selectedDay});
  @override
  _addeventState createState() => _addeventState(uid:uid,selectedDay:selectedDay);
}



class  _addeventState extends State<addevent> {
  final _formKey = GlobalKey<FormState>();

  supportMessage message=new supportMessage();

  TextEditingController  eventname = TextEditingController();
  TextEditingController eventdesc = TextEditingController();
  String uid;
  DateTime selectedDay;

  _addeventState({required this.uid,required this.selectedDay});

  CollectionReference ref = FirebaseFirestore.instance.collection('calender');

  @override
  void initState() {
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
      //(token) => print(token)
    );
  }

  @override
  Widget build(BuildContext context) {

    String date= selectedDay.toString();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Calendar()));

          },
        ),
        automaticallyImplyLeading: false,
        title:Text('New Event'),
        actions: [
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
              ref.add({
                'uid': uid,
                'eventname': eventname.text,
                'eventdesc': eventdesc.text,
                'selectedDay':date,

              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) =>ListEventScreen()));
              });
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
           Padding(
          padding: EdgeInsets.only(
            left: 3,
            right: 3,
          ),),
            Container(
              //decoration: BoxDecoration(border: Border.all()),
              child: TextFormField(
                controller: eventname,
                decoration: InputDecoration(
                  hintText: 'Event Name',
                ),
                validator : (value)
                {
                  if(value!.isEmpty)
                  {
                    print (value);
                    return "Event Name is Empty!";
                  }
                  else
                  {
                    eventname.text=value;
                    print(value);
                  }
                },
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: eventdesc,
                maxLines: null,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Event Description',
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
          ],
        ),
      ),
    );
  }
}

