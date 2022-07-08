import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/ui/event/event_screen.dart';
import 'package:project/ui/history/accumlative_screen.dart';
import 'package:project/ui/screens/event_screen.dart';
import 'package:project/ui/authentication/login_screen.dart';
import 'package:project/ui/screens/home_screen.dart';
import 'package:project/ui/screens/helper_screen.dart';
import 'package:project/ui/screens/intro_screen.dart';
import 'package:project/ui/screens/location_screen.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:project/ui/screens/symptom_screen.dart';
import 'package:project/ui/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xfff2f9fe),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      home: IntroScreen(),
     routes: {
        'intro': (context) => IntroScreen(),
        'home': (context) => HomeScreen(),
        'login': (context) => LoginScreen(),
        'location': (context) => LocationScreen (),
        'questionnaire' : (context) => QuestionnaireScreen(),
        'alert' :  (context) => Calendar(),
       'helper' :  (context) =>HelperScreen(),
       'settings' :  (context) =>SettingPage(title: '',),
       'events':  (context) =>ListEventScreen(),
       'history': (context) => AccumlativeScreen(),
    },

    );
  }
}

