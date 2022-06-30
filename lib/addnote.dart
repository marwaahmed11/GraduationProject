import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';
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

class addnote extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();
  TextEditingController subject4 = TextEditingController();
  TextEditingController subject5 = TextEditingController();
  TextEditingController subject6 = TextEditingController();
  TextEditingController subject7 = TextEditingController();
  TextEditingController subject8 = TextEditingController();
  TextEditingController subject9 = TextEditingController();
  TextEditingController subject10 = TextEditingController();


  CollectionReference ref = FirebaseFirestore.instance.collection('report');

   int group =1;


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
                'question1': subject1.text,
                'question2': subject2.text,
                'question3': subject3.text,
                'question4': subject4.text,
                'question5': subject5.text,
                'question6': subject6.text,
                'question7': subject7.text,
                'question8': subject8.text,
                'question9': subject9.text,
                'question10': subject10.text

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
                 labelText: 'name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Radio(value: 1,
              groupValue: group,
              onChanged:(T){
              print(T);
              /*setState((){
                group=T;
              })*/;
            },),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject1,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Do you suffer from hair loss?'
                  "هل تعاني من فقدان سقوط الشعر؟",
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
                  labelText: "Do you suffer from loss of appetite?"
                  "هل تعاني من فقدان الشهية؟",
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
                  labelText:"Do you suffer from diarrhea?"
                      "هل تعاني من الاسهال؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject4,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from vomiting?"
                      "هل تعاني من القئ؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject5,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Do you suffer from weight loss?"
                      "هل تعاني من فقدان الوزن؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject6,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from changes in the nails and skin?"
                      "هل تعاني من تغيرات في الأظافر والجلد؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject7,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from changes in ulcers in the mouth?"
                      "هل تعاني من تغيرات تقرحات في الفم؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject8,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from vaginal dryness?"
                      "هل تعاني من جفاف مهبلي؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject9,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from poor memory?"
                      "هل تعاني من ضعف في الذاكرة؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: subject10,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:"Do you suffer from anemia?"
                      "هل تعاني من فقر الدم؟" ,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }
}

