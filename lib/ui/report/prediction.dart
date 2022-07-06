import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  /*@override
  Widget build(BuildContext context) {
    predict();
    String  out='';
    final listMap = x.asMap();
    for(int i=0;i<x.length;i++){
      out =out+ listMap[i].toString()+"\n\n";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Prediction'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[

                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child : Text( out,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20),),
                    ),
                    ],
                  ),
                ),
                /////////////////////////////////////////

              ],
            ),
          ],

        ),
      ),

    );

  }*/

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
        //backgroundColor: Color.fromARGB(255, 0, 11, 133),
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
                              color: Colors.black,
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
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add('exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract'
              + '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية');
      // return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
      return;
    }
    //2
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      // return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
      return;
    }
    //3
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
      //return "Immunodeficiency and exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract";
    }
    //4
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //5
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //6
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //7
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //8
    else if (subject10 == 'yes' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //9
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //10
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //11
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //12
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //13
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //14
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //15
    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //16

    else if (subject10 == 'yes' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      x.add(
          'exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //17
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //18
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      return;
    }
    //19

    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //20
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//21
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//22

    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//23
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('diarrhea' + '\n' + 'إسهال');
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      return;
    }

//24
    else if (subject10 == 'no' && subject7 == 'yes' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('loss of appetite''\n' + 'فقدان الشهية');
      x.add('diarrhea' + '\n' + 'إسهال');
      return;
    }
//25
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite' + '\n' + 'فقدان الشهية');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//26
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite' + '\n' + 'فقدان الشهية');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
    //27
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//28
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'yes' &&
        subject3 == 'no' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//29

    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//30
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'yes' && subject2 == 'no') {
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
      x.add('ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//31
    else if (subject10 == 'no' && subject7 == 'no' && subject4 == 'no' &&
        subject3 == 'no' && subject2 == 'yes') {
      x.add('vomiting' + '\n' + 'التقيؤ');
      x.add('general fatigue' + '\n' + 'التعب العام');
      x.add('weight loss' + '\n' + 'فقدان الوزن');
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