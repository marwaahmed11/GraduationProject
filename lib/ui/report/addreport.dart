import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:project/ui/report/report.dart';
import 'package:project/ui/screens/symptom_screen.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;
/*
class addnote extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
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
          ],
        ),
      ),
    );
  }
}
*/

class addreport extends StatefulWidget {

  String uid;
  addreport({required this.uid});
  @override
  _addreportState createState() => _addreportState(uid:uid);
}

class _addreportState extends State<addreport> {

  String uid;
  _addreportState({required this.uid});

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

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //////////////////////////////////////////////
  //String name='';
  TextEditingController name = TextEditingController();
  String?  _radioBoxValue1 = 'None';
  String? _radioBoxValue2 = 'None';
  String? _radioBoxValue3 = 'None';
  String? _radioBoxValue4 = 'None';
  String? _radioBoxValue5 = 'None';
  String? _radioBoxValue6 = 'None';
  String? _radioBoxValue7 = 'None';
  String? _radioBoxValue8 = 'None';
  String? _radioBoxValue9 = 'None';
  String? _radioBoxValue10 = 'None';
  String? _radioBoxValue11 = 'None';

  String date = DateFormat.yMMMd().format(DateTime.now());


  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Report"),
        backgroundColor: Colors.pink[200],
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>QuestionnaireScreen()));

          },
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'date':date,
                'uid' :uid,
                'name':  name.text,
                'question1': _radioBoxValue1,
                'question2': _radioBoxValue2,
                'question3': _radioBoxValue3,
                'question4': _radioBoxValue4,
                'question5':_radioBoxValue5,
                'question6': _radioBoxValue6,
                'question7': _radioBoxValue7,
                'question8': _radioBoxValue8,
                'question9': _radioBoxValue9,
                'question10': _radioBoxValue10,
                'question11': _radioBoxValue11

              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [////////
            Padding(
            padding: const EdgeInsets.all(5),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  //decoration: BoxDecoration(border: Border.all()),
                  child: TextField(
                    controller: name,
                     decoration: InputDecoration(
                         labelText: 'First Name',
                ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),


                _GroupText("1- Do you suffer from hair loss?"
                    "هل تعاني من فقدان سقوط الشعر؟"),

                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value.toString();
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("2- Do you suffer from loss of appetite?"
                    "هل تعاني من فقدان الشهية؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "3- Do you suffer from diarrhea?"
                    "هل تعاني من الاسهال؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value  to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("4- Do you suffer from vomiting?"
                    "هل تعاني من القئ؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("5- Do you suffer from weight loss?"
                    "هل تعاني من فقدان الوزن؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("6- Do you suffer from changes in the nails and skin?"
                    "هل تعاني من تغيرات في الأظافر والجلد؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("7- Do you suffer from changes in ulcers in the mouth?"
                    "هل تعاني من تغيرات تقرحات في الفم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("8- Do you suffer from vaginal dryness?"
                    "هل تعاني من جفاف مهبلي؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "9- Do you suffer from poor memory?"
                    "هل تعاني من ضعف في الذاكرة؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("10- Do you suffer from anemia?"
                    "هل تعاني من فقر الدم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            // TextField
            // DateTimePicker

            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("11- Do you suffer from nerve damage?"
                    "هل تعاني من تلف الاعصاب؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            // TextField
            // DateTimePicker
            SizedBox(
              height: 50,
            ),


          ],
        ),
      ),
    );
  }







  void _showToast(String text) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ));
  }
}

class _GroupText extends StatelessWidget {
  final String text;

  const _GroupText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        text,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
  }
}
/*
class _SpaceLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }
}*/