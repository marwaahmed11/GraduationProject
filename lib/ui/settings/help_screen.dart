import 'package:firebase_auth/firebase_auth.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../supportmessage.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  HelpScreen();
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  _HelpScreenState();
  String uid='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;
  }

  supportMessage message=new supportMessage();

  @override
  void initState() {
    super.initState();

    getCurrentUser();

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
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Help'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help  ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) =>HelpScreen()));
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
        child: Column(
        children: [
          SizedBox(
            height: 4,
            width: double.infinity,
          ),
           Card(
             color: Colors.grey,
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 120,vertical: 10),
               child: Text(
                 'Log a Symptom ',
                 style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
               ),
             ),
            ),
          Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is to enable users to log their answers in terms of formal"
                    " MCQ questions that is made by doctors about some symptom and signs that may occur to them"
                    " during the day after chemotherapy in order to make the doctor must know their answers to determine"
                    " the extent of improvement or worsening of the case. ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150,vertical: 10),
              child: Text(
                'Predict',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is to predict what symptoms may happen to the patient according to the result of analysing patient’s answer and comparing it to the instructions that we took from expert doctors in tumour’s.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130,vertical: 10),
              child: Text(
                'Show advice',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is to give advice to the patient to help him treating the symptoms that happened to him and avoiding other symptoms that may occur as a result of currently symptoms.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80,vertical: 10),
              child: Text(
                'Formulate a medical report',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality uses the answers of the patient’s questionnaire to formulate a report about what happened to the patient during any day when the patient feel any of these symptoms and send it to a chosen doctor.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 10),
              child: Text(
                ' Formulate history report',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(

            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is used to report all the symptoms that happened to the patient from the beginning of the disease. ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 142,vertical: 10),
              child: Text(
                'Set event',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is to help the patient to set events for any appointments like chemo sessions times, rumours & analysis and doctor appointments to remind them about it.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 124,vertical: 10),
              child: Text(
                'Send Location',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(

            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),

              ),
              title: Text(
                    "This functionality is to allow the patient to send his current location to a chosen helper when there is an emergency case to help him as soon as possible.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 3,
          ),
          Card(
            color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90,vertical: 10),
              child: Text(
                'Send support notification',
                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Material(

            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(
                    "This functionality is sent periodically to the patients in order to help, support and maintain their psychological and mental condition.",
                style: TextStyle(
                  fontSize: 18,
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
    )
      ),
      );
  }
}
























