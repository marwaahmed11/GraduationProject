import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import '../../model/user_model.dart';
import '../screens/helper_screen.dart';

/*
class addhelper extends StatefulWidget {

  String uid;
 addhelper({required this.uid});
  @override
  _addhelperState createState() => _addhelperState(uid:uid);
}



class  _addhelperState extends State<addhelper> {
  TextEditingController  name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();
  //TextEditingController uid = TextEditingController();
  String uid;
  //UserModel userModel = UserModel();
  //addhelper({required UserModel uid});
  _addhelperState({required this.uid});

  //User? user = FirebaseAuth.instance.currentUser;

  CollectionReference ref = FirebaseFirestore.instance.collection('helpers');

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
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
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title:Text('Add'),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'uid': uid,
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,
                'email': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HelperScreen()));
              });
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HelperScreen()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'firstname',
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
                  hintText: 'lastname',
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
                  hintText: 'number',
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
                  hintText: 'email',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

class addhelper extends StatefulWidget {

  String uid;
  addhelper({required this.uid});
  @override
  _addhelperState createState() => _addhelperState(uid:uid);
}



class  _addhelperState extends State<addhelper> {
  TextEditingController  name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();

  //TextEditingController uid = TextEditingController();
  String uid;
  bool _validate = false;
  final _formKey = GlobalKey<FormState>();
  //UserModel userModel = UserModel();
  //addhelper({required UserModel uid});
  _addhelperState({required this.uid});

  //User? user = FirebaseAuth.instance.currentUser;

  CollectionReference ref = FirebaseFirestore.instance.collection('helpers');

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Health");

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
    final number = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.number,
        controller: subject2,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      validator : (value)
      {
        if(value==null || value.isEmpty)
        {
          return ("Number is Empty!");
        }
        return null;
      },
      onSaved: (value) {
        subject2.text = value!;
      },
    );



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
             onPressed: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HelperScreen()));

             },
        ),
        automaticallyImplyLeading: false,
        title:Text('New Helper'),
        actions: [
         /* IconButton(
            icon: const Icon(Icons.arrow_back ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HelperScreen()));
            },
          ),*/
          MaterialButton(
            onPressed: () {

             /* print(name.text);
              print(subject1.text);
              print(subject2.text);*/
    /////////if (_formKey.currentState!.validate()){
                print("on pressed");
                ref.add({
                'uid': uid,
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,

                }).whenComplete(() {
                Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HelperScreen()));
                });
   /////// }
    /*else
      {
        print("errorrrrrrrrrrrrr");
      }*/

            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
         /* MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HelperScreen()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),*/

        ],
      ),

     /* floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.fullscreen_exit),
        onPressed: () {
          Navigator.pushReplacementNamed(context, "helper");
        },
      ),*/
      body: SingleChildScrollView(
        child: Column(
          key: _formKey,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
             // decoration: BoxDecoration(border: Border.all()),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'First Name',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator : (value)
                {
                  if(value==null || value.isEmpty)
                  {
                    print("Empty first");
                    return ("First Name is Empty!");
                  }
                  print("first");
                  return null;
                },
                onSaved: (value) {
                  name.text = value!;
                  print(name.text);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
             // decoration: BoxDecoration(border: Border.all()),
              child: TextFormField(
                controller: subject1,
                maxLines: null,
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Last Name',

                ),
                validator : (value)
                  {
                    if(value==null || value.isEmpty)
                      {
                        return ("Last Name is Empty!");
                      }
                    return null;
                  },
                onSaved: (value) {
                  subject1.text = value!;
                },

              ),
            ),

            SizedBox(
              height: 10,
            ),
              number,
          ],
        ),
      ),
    );
  }
}

