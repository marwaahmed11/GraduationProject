import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class prediction extends StatefulWidget {
  DocumentSnapshot docid;
  prediction({required this.docid});
  @override
  State<prediction> createState() => _predictionState(docid: docid);
}

class _predictionState extends State<prediction> {
  DocumentSnapshot docid;

  //DocumentSnapshot uid;
  _predictionState({required this.docid});

  // final pdf = pw.Document();
  var name;
  var subject1;
  var subject2;
  var subject3;
  var subject4;
  var subject5;
  var subject6;
  var subject7;
  var subject8;
  var subject9;
  var subject10;
  List<String> x = [];

  void initState() {
    setState(() {
      name = widget.docid.get('name');
      subject1 = widget.docid.get('question1'); //hair loss
      subject2 = widget.docid.get('question2'); //loss of appetite
      subject3 = widget.docid.get('question3'); //diarrhea
      subject4 = widget.docid.get('question4'); //vomiting
      subject5 = widget.docid.get('question5'); //weight loss
      subject6 = widget.docid.get('question6'); //changes in skin
      subject7 = widget.docid.get('question7'); //ulcers in mouth
      subject8 = widget.docid.get('question8'); //vaginal dryness
      subject9 = widget.docid.get('question9'); //poor memory
      subject10 = widget.docid.get('question10'); //anemia
      //////////////nerve damage

      // marks = int.parse(subject1) + int.parse(subject2) + int.parse(subject3);
    });

    requestPermission();

    loadFCM();

    listenFCM();

    getToken();

    FirebaseMessaging.instance.subscribeToTopic("Health");

    sendPushMessage();

    if (subject1 == 'None' || subject1 == '') {
      subject1 = 'no';
    }
    else {
      subject1 = 'yes';
    }

    if (subject2 == 'None' || subject2 == '') {
      subject2 = 'no';
    }
    else
      subject2 = 'yes';

    if (subject3 == 'None' || subject3 == '') {
      subject3 = 'no';
    }
    else
      subject3 = 'yes';

    if (subject4 == 'None' || subject4 == '') {
      subject4 = 'no';
    }
    else
      subject4 = 'yes';

    if (subject5 == 'None' || subject5 == '') {
      subject5 = 'no';
    }
    else
      subject5 = 'yes';

    if (subject6 == 'None' || subject6 == '') {
      subject6 = 'no';
    }
    else
      subject6 = 'yes';
    if (subject7 == 'None' || subject7 == '') {
      subject7 = 'no';
    }
    else
      subject7 = 'yes';
    if (subject8 == 'None' || subject8 == '') {
      subject8 = 'no';
    }
    else
      subject8 = 'yes';

    if (subject9 == 'None' || subject9 == '') {
      subject9 = 'no';
    }
    else
      subject9 = 'yes';

    if (subject10 == 'None' || subject10 == '') {
      subject10 = 'no';
    }
    else
      subject10 = 'yes';


    super.initState();
  }
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";



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
    predict();
    String out = '';
    final listMap = x.asMap();
    for (int i = 0; i < x.length; i++) {
      out = out + listMap.toString() + "\n";
    }
    String note = '** This prediction may differ from one patient to another.';
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Predition'),
      ),
      /*  Padding(
          padding: EdgeInsets.all(8.0),
          child : Text( note,
            style: TextStyle(
                color: Colors.red,
                fontSize: 20),),
        )*/
      body: StreamBuilder(
        // stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            /////////////////

            child: ListView.builder(
              itemCount: x.length,
              itemBuilder: (_, index) {
                print("helloooooooooooooooo");

                return GestureDetector(
                  child: Column(
                    children: [
                      /* GestureDetector(
                          onTap: () {}, child: const Text("** This prediction may differ from one patient to another.")),*/
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( "This symptom may or may not occur, depending on your case",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor:Colors.orange,
                              // fontStyle:,
                              //fontStyle:  ,
                              fontSize: 13),),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black12,
                            ),
                          ),
                          title: Text(
                            listMap[index].toString(), //////////////////
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
              },
            ),
          );
        },
      ),
    );
  }

  void predict() {
    if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add('Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract'
              + '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية');
      // return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
      return;
    }
    //2
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      // return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
      return;
    }
    //3
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
      //return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
    }
    //4
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //5
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //6
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //7
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //8
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //9
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //10
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //11
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //12
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //13
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //14
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //15
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //16

    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //17
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //18
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      return;
    }
    //19

    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //20
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//21
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//22

    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//23
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('Diarrhea' + '\n' + 'إسهال');
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }

//24
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('Loss of appetite''\n' + 'فقدان الشهية');
      x.add('Diarrhea' + '\n' + 'إسهال');
      return;
    }
//25
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//26
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
    //27
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//28
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//29

    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//30
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      x.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//31
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('Vomiting' + '\n' + 'التقيؤ');
      x.add('General fatigue' + '\n' + 'التعب العام');
      x.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//32
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('No prediction' + '\n' + 'لا يوجد توقع');
      return;
    }
    else {
      x.add('No prediction' + '\n' + 'لا يوجد توقع');
      return;
    }
  }
}