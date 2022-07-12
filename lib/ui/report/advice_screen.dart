import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../supportmessage.dart';
class AdviceScreen extends StatefulWidget {
  DocumentSnapshot docid;
  AdviceScreen({required this.docid});

  @override
  _advicepageState createState() => _advicepageState(docid: docid);
}

class _advicepageState extends State<AdviceScreen> {
  DocumentSnapshot docid;
  _advicepageState({required this.docid});

  List<String> subject= [];
  List<String> list = [];

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
    advice();
    if(list.length==0)
      list.add('No Advice '+"\n"+"Please check with your Doctor"+'\n'+'لا يوجد نصيحة'+'\n'+'يرجى مراجعة طبيبك');

    final listMap = list.asMap();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: Text('Advice'),
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
                return GestureDetector(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( "This recommendation needs to be followed under your doctor's guidance.",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor:Colors.orange,
                              fontSize: 14),),
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
  void advice()  {

    //1
    if(subject[2]=='yes'||subject[5]=='yes'){
      list.add('Advice for Loss of Appetite and Weight Loss: '+'\n'+'Eat food containing these vitamins:'+'\n'+'Zinc, B12, B1'+'\n'
          +': نصائح لفقدان الشهية وفقدان الوزن*' + '\n' + ': تناول الأطعمة التي تحتوي على هذه الفيتامينات  ' + '\n' + 'الزنك ، ب 12 ، ب 1');

    }
    if(subject[3]=='yes'){
      list.add('Advice for Diarrhea: '+'\n'+'Should drink plenty of water, fluids, and foods rich in potassium and pectin. '
          +'\n'+'Avoid fatty foods that contain sugar, caffeine, fiber and dairy products. '+'\n'
          ": نصيحة للإسهال*" + "\n" + "يجب شرب الكثير من الماء والسوائل والأطعمة الغنية بالبوتاسيوم والبكتين. "
          + '\n' + 'تجنب الأطعمة الدهنية التي تحتوي على السكر والكافيين والألياف ومنتجات الألبان. '
      );
    }
    if(subject[4]=='yes'){
      list.add('Advice for Vomiting: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B6'+'\n'+
          ': نصائح للتقيؤ*' + '\n' + ': تناول الأطعمة التي تحتوي على هذه الفيتامينات' + '\n' + 'الزنك ، ب 6');

    }
    if(subject[7]=='yes'){
      list.add('Advice for Ulcers In Mouth: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, B6'+'\n'+'Mouthwash'+'\n'
          + ': نصيحة للقرحة في الفم*'+ '\n' + ': تناول الأطعمة التي تحتوي على هذه الفيتامينات ' + '\n' + ' ب 12، ب 6'+'\n'+'غسول الفم'
      );

    }
    if(subject[9]=='yes'){
      list.add('Advice for Poor Memory: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, E, D3, Omega 3'
          +'\n' + 'نصيحة لضعف الذاكرة*'+ '\n' + ' : تناول الأطعمة التي تحتوي على هذه الفيتامينات' + '\n' + ' أوميغا 3، ه، ب 12، د 3');

    }
    if(subject[10]=='yes'){
      list.add('Advice for Anemia: '+'\n'+'Eat food containing these vitamins:'+'\n'+'Iron, B12, folic acid, C'+'\n'+'Please Check with your doctor'
          +'\n' + ': نصائح لفقر الدم*'+ '\n' + ': تناول الأطعمة التي تحتوي على هذه الفيتامينات' + '\n' + 'الحديد ، ب 12 ، حمض الفوليك ،ج'
          +'\n'+'يرجى مراجعة طبيبك');
    }
    if(subject[11]=='yes'){
      list.add('Advice for Nerve Damage: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, Omega 3, B1, B2, B6'
          +'\n'+': نصائح لتلف العصب*'+ '\n' + ': تناول الأطعمة التي تحتوي على هذه الفيتامينات' + '\n' + ' ب 12، ب 1، ب 2، ب3، ب 6، أوميغا 3' );

    }
  }
}