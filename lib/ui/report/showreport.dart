import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/ui/screens/prediction.dart';
import 'package:project/ui/screens/questionnaire_screen.dart';
import '../../main.dart';
import '../screens/advice_screen.dart';
import 'report.dart';
import 'package:http/http.dart' as http;
/*
class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('name'));
    subject1 = TextEditingController(text: widget.docid.get('Maths'));
    subject2 = TextEditingController(text: widget.docid.get('Science'));
    subject3 = TextEditingController(text: widget.docid.get('History'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name.text,
                'Maths': subject1.text,
                'Science': subject2.text,
                'History': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "delete",
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
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'name',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject1,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Maths',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject2,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Science',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: subject3,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'History',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color.fromARGB(255, 0, 11, 133),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

class showreport extends StatefulWidget {
  DocumentSnapshot docid;
  String uid;
  showreport({required this.docid,required this.uid});

  @override
  _showreportState createState() => _showreportState(docid: docid,uid:uid);
}

class _showreportState extends State<showreport> {
  DocumentSnapshot docid;
  String uid;
  _showreportState({required this.docid,required this.uid});


  String name='';

  String subject1 ='';
  String subject2 ='';
  String subject3='' ;
  String subject4 ='' ;
  String subject5 ='' ;
  String subject6  ='';
  String subject7 ='' ;
  String subject8  ='';
  String subject9 ='' ;
  String subject10='';
  String subject11='';
  String date='';
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
    date=widget.docid.get('date');
    name = widget.docid.get('name');
    subject1 =  widget.docid.get('question1');
    subject2 =  widget.docid.get('question2');
    subject3 =  widget.docid.get('question3');
    subject4 =  widget.docid.get('question4');
    subject5 =  widget.docid.get('question5');
    subject6 =  widget.docid.get('question6');
    subject7 =  widget.docid.get('question7');
    subject8 =  widget.docid.get('question8');
    subject9 =  widget.docid.get('question9');
    subject10 = widget.docid.get('question10');
    subject11 = widget.docid.get('question11');


    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Animal");

    sendPushMessage();
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAwyqJYMY:APA91bE_gBwYDgr9-puMHLyY6s5OTowlcv62FPi4XRdUqAPivmF8MX4TMtAzNifUwIDEn0CiqXcoJfglYpYcTqWnQbzXzqfd1JeBHlLQnnu1MHGEO6uovuKuzsI6ASKqGoeH5VwDJhyQ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test Body',
              'title': 'Test Title 2'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$token",
          },
        ),
      );
      print("heyyyyyyyyyyyyyyyyyyyy");
    } catch (e) {
      print("error push notification");
    }
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

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }



/*  @override
  void initState() {
    name = widget.docid.get('name');
    subject1 =  widget.docid.get('question1');
    subject2 =  widget.docid.get('question2');
    subject3 =  widget.docid.get('question3');
    subject4 =  widget.docid.get('question4');
    subject5 =  widget.docid.get('question5');
    subject6 =  widget.docid.get('question6');
    subject7 =  widget.docid.get('question7');
    subject8 =  widget.docid.get('question8');
    subject9 =  widget.docid.get('question9');
    subject10 = widget.docid.get('question10');

    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Show Report",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 251, 251, 251),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),

          ),
          /* MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name.text,
                'Maths': subject1.text,
                'Science': subject2.text,
                'History': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),*/
          /*MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name,
                'question1': subject1,
                'question2': subject2,
                'question3': subject3,
                'question4': subject4,
                'question5': subject5,
                'question6': subject6,
                'question7': subject7,
                'question8': subject8,
                'question9': subject9,
                'question10': subject10

              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),*/
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
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
                //decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'Created date: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
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
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  'What is your name?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
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
                color: Colors.black,
                thickness: 1,
              ),

              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "1- Do you suffer from hair loss?"
                      "هل تعاني من فقدان سقوط الشعر؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
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
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "2- Do you suffer from loss of appetite?"
                      "هل تعاني من فقدان الشهية؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),

                child:  Text(
                  subject2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
               // decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "3- Do you suffer from diarrhea?"
                      "هل تعاني من الاسهال؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject3,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
               // decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "4- Do you suffer from vomiting?"
                      "هل تعاني من القئ؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject4,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
               // decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "5- Do you suffer from weight loss?"
                      "هل تعاني من فقدان الوزن؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "6- Do you suffer from changes in the nails and skin?"
                      "هل تعاني من تغيرات في الأظافر والجلد؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject6,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "7- Do you suffer from changes in ulcers in the mouth?"
                      "هل تعاني من تغيرات تقرحات في الفم؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject7,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "8- Do you suffer from vaginal dryness?"
                      "هل تعاني من جفاف مهبلي؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject8,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "9- Do you suffer from poor memory?"
                      "هل تعاني من ضعف في الذاكرة؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject9,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "10- Do you suffer from anemia?"
                      "هل تعاني من فقر الدم؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject10,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                //decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "11- Do you suffer from nerve damage?"
                      "هل تعاني من تلف الاعصاب؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),),
                child:  Text(
                  subject11,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),


              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,uid:uid
                      ),
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
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => prediction(
                        docid: docid,

                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Prediction",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdviceScreen(docid :docid),
                    ),
                  );
                },
                child: Text(
                  "Show Advice",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

