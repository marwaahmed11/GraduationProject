
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/ui/screens/home_screen.dart';
/*
class editUserScreen extends StatefulWidget {
  editUserScreen();

  @override
  _edituserState createState() => _edituserState();
}

class _edituserState extends State<editUserScreen> {

  String a = '';
  late DocumentSnapshot uid;
  _edituserState();

  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController toEmail = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {

    User? user = await _auth.currentUser;
    a = user!.uid;
   uid= fetchCurrentUser(a) as DocumentSnapshot<Object?>;
  }
  Future<DocumentSnapshot> fetchCurrentUser(String uuid) async {
    return await FirebaseFirestore.instance.collection('users').doc(uuid).get();

  }

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() async {
    User? user = await _auth.currentUser;
    a = user!.uid;
    DocumentSnapshot uid=await FirebaseFirestore.instance.collection('users').doc(a).get();


    name = TextEditingController(text: widget.uid.get('firstname'));
    subject1 = TextEditingController(text: widget.docid.get('lastname'));
    subject2 = TextEditingController(text: widget.docid.get('number'));
    toEmail = TextEditingController(text: widget.docid.get('email'));

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
        title:Text('Edit'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
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
              widget.uid.reference.update({
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,
                'email': toEmail.text
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HelperScreen()));
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
                  controller: toEmail,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Text('${Address}'),
              ElevatedButton(
                  onPressed: () async{
                    getlocation();
                    String number = subject2.text;
                    String x = name.text+",please help me in this location "+Address;
                    final url='sms:$number?body=$x';
                    customLaunch(url);
                  },

                  child: Text('Send Location')),
              //Text('${Address}'),

            ],
          ),
        ),
      ),
    );
  }

}
*/

