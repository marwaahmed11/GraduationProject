import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../supportmessage.dart';
class prediction extends StatefulWidget {
  DocumentSnapshot docid;
  prediction({required this.docid});
  @override
  State<prediction> createState() => _predictionState(docid: docid);
}

class _predictionState extends State<prediction> {
  DocumentSnapshot docid;
  _predictionState({required this.docid});


  List<String> list = [];
  List<String> subject = [];
  void initState() {
    setState(() {
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

    });
    analysis();

    super.initState();

  }

  void analysis()
  {
    if (subject[1] == 'None' || subject[1] == '') {
      subject[1] = 'no';
    }
    else {
      subject[1] = 'yes';
    }

    if (subject[2] == 'None' || subject[2] == '') {
      subject[2] = 'no';
    }
    else
      subject[2] = 'yes';

    if (subject[3] == 'None' || subject[3] == '') {
      subject[3] = 'no';
    }
    else
      subject[3] = 'yes';

    if (subject[4] == 'None' || subject[4] == '') {
      subject[4] = 'no';
    }
    else
      subject[4] = 'yes';

    if (subject[5] == 'None' || subject[5] == '') {
      subject[5] = 'no';
    }
    else
      subject[5] = 'yes';

    if (subject[6] == 'None' || subject[6] == '') {
      subject[6] = 'no';
    }
    else
      subject[6] = 'yes';
    if (subject[7]== 'None' || subject[7]== '') {
      subject[7] = 'no';
    }
    else
      subject[7] = 'yes';
    if (subject[8] == 'None' || subject[8] == '') {
      subject[8] = 'no';
    }
    else
      subject[8] = 'yes';

    if (subject[9] == 'None' || subject[9] == '') {
      subject[9] = 'no';
    }
    else
      subject[9] = 'yes';

    if (subject[10]== 'None' || subject[10] == '') {
      subject[10] = 'no';
    }
    else
      subject[10] = 'yes';

  }


  @override
  Widget build(BuildContext context) {
    predict();
    String out = '';
    final listMap = list.asMap();
    for (int i = 0; i < list.length; i++) {
      out = out + listMap.toString() + "\n";
    }
    return Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.pink[200],
        title: Text('Predition'),
      ),

      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),


            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                print("helloooooooooooooooo");

                return GestureDetector(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( "In your case, this symptom may or may not manifest.",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor:Colors.orange,
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
                            listMap[index].toString(),
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
    if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add('Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract'
              + '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية');
      return;
    }
    //2
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //3
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //4
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //5
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //6
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //7
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //8
    else if (subject[10] == 'yes' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //9
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //10
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //11
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //12
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //13
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //14
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //15
    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //16

    else if (subject[10] == 'yes' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('Immunodeficiency' + '\n' + 'نقص المناعة');
      list.add(
          'Exposure to infections such as sore throat, high temperature, inflammation of the respiratory tract and urinary tract' +
              '\n' +
              'التعرض للعدوى مثل التهاب الحلق وارتفاع درجة الحرارة والتهاب الجهاز التنفسي والمسالك البولية);');
      return;
    }
    //17
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //18
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      return;
    }
    //19

    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
    //20
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//21
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//22

    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//23
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('Diarrhea' + '\n' + 'إسهال');
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }

//24
    else if (subject[10] == 'no' && subject[7] == 'yes' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('Loss of appetite''\n' + 'فقدان الشهية');
      list.add('Diarrhea' + '\n' + 'إسهال');
      return;
    }
//25
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//26
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
    //27
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//28
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'yes' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Loss of appetite' + '\n' + 'فقدان الشهية');
      return;
    }
//29

    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//30
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'yes' && subject[2] == 'no') {
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      list.add('Ulcers in mouth' + '\n' + 'تقرحات في الفم');
      return;
    }
//31
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'yes') {
      list.add('Vomiting' + '\n' + 'التقيؤ');
      list.add('General fatigue' + '\n' + 'التعب العام');
      list.add('Weight loss' + '\n' + 'فقدان الوزن');
      return;
    }
//32
    else if (subject[10] == 'no' && subject[7] == 'no' && subject[4] == 'no' &&
        subject[3] == 'no' && subject[2] == 'no') {
      list.add('No prediction' + '\n' + 'لا يوجد توقع');
      return;
    }
    else {
      list.add('No prediction' + '\n' + 'لا يوجد توقع');
      return;
    }
  }
}

