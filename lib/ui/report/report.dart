import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class reportt extends StatefulWidget {
  String uid='';
  DocumentSnapshot docid;
  reportt({required this.docid,required this.uid});
  @override
  State<reportt> createState() => _reporttState(docid: docid,uid:uid);
}

class _reporttState extends State<reportt> {
  DocumentSnapshot docid;
  String uid='';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;}

  _reporttState({required this.docid,required this.uid});
  final pdf = pw.Document();
  var date;
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
  var subject11;


  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  String? token = " ";

  @override
  void initState() {

    setState(() {
      date=widget.docid.get('date');
      uid= widget.docid.get('uid');
      name = widget.docid.get('name');
      subject1 = widget.docid.get('question1');
      subject2 = widget.docid.get('question2');
      subject3 = widget.docid.get('question3');
      subject4 = widget.docid.get('question4');
      subject5 = widget.docid.get('question5');
      subject6 = widget.docid.get('question6');
      subject7 = widget.docid.get('question7');
      subject8 = widget.docid.get('question8');
      subject9 = widget.docid.get('question9');
      subject10 = widget.docid.get('question10');
      subject11 = widget.docid.get('question11');

      // marks = int.parse(subject1) + int.parse(subject2) + int.parse(subject3);
    });
    super.initState();
    getCurrentUser();

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
    return PdfPreview(
      maxPageWidth: 1000,
      //useActions: false,
      //canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,


      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final font1 = await PdfGoogleFonts.openSansLight();
    final font2 = await PdfGoogleFonts.openSansLight();

    String? _logo = await rootBundle.loadString('assets/r2.svg');

  /*  doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 10,
            marginLeft: 10,
            marginRight: 10,
            marginTop: 10,
          ),
          //pageFormat: PdfPageFormat.,
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Center(
                    child: pw.Text(
                      'Final Report card',
                      style: pw.TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Created date : ',
                        style: pw.TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      pw.Text(
                       date,
                        style: pw.TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  pw.Divider(),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'name : ',
                        style: pw.TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      pw.Text(
                        name,
                        style: pw.TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from hair loss? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject1,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from loss of appetite? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject2,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from diarrhea? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject3,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from vomiting? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject4,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from weight loss? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject5,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from changes in skin? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject6,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from ulcers in mouth? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject7,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from vaginal dryness? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject8,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from poor memory? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject9,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from anemia? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject10,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        "Do you suffer from nerve damage? :",
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      pw.Text(
                        subject11,
                        style: pw.TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  pw.Divider(),
                  /* pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Total : ',
                        style: pw.TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      pw.Text(
                        marks.toString(),
                        style: pw.TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),*/
                ],
              ));
        },
      ),
    );*/
    doc.addPage(
        pw.MultiPage(
            margin: pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return <pw.Widget>[
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      /*pw.Text('Create a Simple PDF',
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(fontSize: 26)),*/
                     // pw.Divider(),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisSize: pw.MainAxisSize.max,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          'Final Report card',
                          style: pw.TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),

                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'Created date : ',
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            date,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      pw.Divider(),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'name : ',
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from hair loss? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject1,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from loss of appetite? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject2,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from diarrhea? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject3,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from vomiting? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject4,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from weight loss? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject5,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from changes in skin? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject6,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from ulcers in mouth? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject7,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from vaginal dryness? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject8,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from poor memory? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject9,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from anemia? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject10,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Do you suffer from nerve damage? :",
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          pw.Text(
                            subject11,
                            style: pw.TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Divider(),
                      /* pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(
                        'Total : ',
                        style: pw.TextStyle(
                          fontSize: 50,
                        ),
                      ),
                      pw.Text(
                        marks.toString(),
                        style: pw.TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),*/
                    ],

                ),
              ];
            })
    );
    Expanded(
      child: SingleChildScrollView(
        /*child: Visibility(
          //visible: pdfFile.isNotEmpty,
          //child: SfPdfViewer.file(File(pdfFile),
              canShowScrollHead: false, canShowScrollStatus: false),*/
        ),
      );

    return doc.save();
  }
}