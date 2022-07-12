import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/report/prediction.dart';
import 'package:project/ui/screens/symptom_screen.dart';
import '../../supportmessage.dart';
import 'advice_screen.dart';
import 'report.dart';

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
  supportMessage message=new supportMessage();

/*
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
  String subject11='';*/
  List<String> subject = [];
  String date='';


  @override
  void initState() {
    date=widget.docid.get('date');
    subject.add(widget.docid.get('Name'));
    subject.add(widget.docid.get('Hair_loss')); //hair loss
    subject.add(widget.docid.get('Loss_of_appetite')); //loss of appetite
    subject.add(widget.docid.get('Diarrhea')); //diarrhea
    subject.add(widget.docid.get('Vomiting')); //vomiting
    subject.add(widget.docid.get('Weight_loss')); //weight loss
    subject.add(widget.docid.get('Changes_in_skin')); //changes in skin
    subject.add(widget.docid.get('Ulcers_in_mouth')); //ulcers in mouth
    subject.add(widget.docid.get('Vaginal_dryness')); //vaginal dryness
    subject.add(widget.docid.get('Poor_memory')); //poor memory
    subject.add(widget.docid.get('Anemia')); //anemia
    subject.add(widget.docid.get('Nerve_damage')); //nerve damage


    super.initState();

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

  void actionPopUpItemSelected(String value, String name) {
    String message;
    if (value == 'report') {
      message = ' selected report for $name';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => reportt(
              docid: docid,uid:uid
          ),
        ),
      );
    } else if (value == 'prediction') {
      message = 'selected prediction $name';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => prediction(
            docid: docid,
          ),
        ),
      );
    }
    else if (value == 'advice') {
      message = 'selected advice for $name';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AdviceScreen(docid :docid),
        ),
      );
    }
    else if (value == 'delete') {
      message = 'You selected delete for $name';
      widget.docid.reference.delete().whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
      });

    }
    else {
      message = 'Not implemented';
    }
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    int group =1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show Report",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),

        ),
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));

          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'report',
                    child: Text('Make Report'),
                ),
                PopupMenuItem(
                  value: 'prediction',
                  child: Text('Make Prediction'),
                ),
                PopupMenuItem(
                  value: 'advice',
                  child: Text('Show Advice'),
                ),                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete Report'),
                )
              ];
            },
            onSelected: (String value){
              print('You Click on po up menu item');
              actionPopUpItemSelected(value, subject[0]);
            },
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
                  'Created date : ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black12,
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
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child: Text(
                  subject[0],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),

              Container(
                child:  Text(
                  "1- Do you suffer from hair loss?"+"\n"+
                      "هل تعاني من سقوط الشعر؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[1],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "2- Do you suffer from loss of appetite?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),

                child:  Text(
                  subject[2],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "3- Do you suffer from diarrhea?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[3],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "4- Do you suffer from vomiting?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[4],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "5- Do you suffer from weight loss?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[5],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "6- Do you suffer from changes in the nails and skin?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[6],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "7- Do you suffer from changes in ulcers in the mouth?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[7],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "8- Do you suffer from vaginal dryness?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[8],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "9- Do you suffer from poor memory?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[9],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "10- Do you suffer from anemia?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[10],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 2,
              ),
              Container(
                child:  Text(
                  "11- Do you suffer from nerve damage?"+"\n"+
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
                  color: Colors.black12,
                  width: 1,
                ),),
                child:  Text(
                  subject[11],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );



  }
}
