import 'dart:convert';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../../mainscreen.dart';

class QuestionnairePage extends StatefulWidget {
  QuestionnairePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<QuestionnairePage> {

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

/////////
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),


      body: ConditionalQuestions(
        key: _key,
        children: questions(),
        trailing: [
          MaterialButton(
            color: Colors.deepOrange,
            splashColor: Colors.orangeAccent,
            onPressed: () async {
              if (_key.currentState!.validate()) {
                print("validated!");
              }
            },
            child: Text("Submit"),
          )
        ],
      ),
    );
  }
}
List<Question> questions() {
  return [
    Question(
      question: "What is your name?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    PolarQuestion(
        question: "Do you suffer from hair loss?"
            "هل تعاني من فقدان سقوط الشعر؟",
        answers: ["None لا","Mid متوسط","Severe حاد"],
        isMandatory: true),
    PolarQuestion(
        question: "Do you suffer from loss of appetite?"
            "هل تعاني من فقدان الشهية؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from diarrhea?"
            "هل تعاني من الاسهال؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from vomiting?"
            "هل تعاني من القئ؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from weight loss?"
            "هل تعاني من فقدان الوزن؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from changes in the nails and skin?"
            "هل تعاني من تغيرات في الأظافر والجلد؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from changes in ulcers in the mouth?"
            "هل تعاني من تغيرات تقرحات في الفم؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from vaginal dryness?"
            "هل تعاني من جفاف مهبلي؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from poor memory?"
            "هل تعاني من ضعف في الذاكرة؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    PolarQuestion(
        question: "Do you suffer from anemia?"
            "هل تعاني من فقر الدم؟",
        answers: ["None لا","Mid متوسط","Severe حاد"]),
    Question(
      question: "Comments",
    ),

  ];
}


