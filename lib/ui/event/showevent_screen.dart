import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/ui/report/prediction.dart';
import 'package:project/ui/screens/symptom_screen.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

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
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
    date=widget.docid.get('selectedDay');
    name = widget.docid.get('eventname');
    subject1 =  widget.docid.get('eventdesc');


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
          /*MaterialButton(
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

          ),*/

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
                //decoration: BoxDecoration(border: Border.all()),
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
            ],
          ),
        ),
      ),
    );



  }
}
