import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdviceScreen extends StatefulWidget {
  DocumentSnapshot docid;
  AdviceScreen({required this.docid});

  @override
  _advicepageState createState() => _advicepageState(docid: docid);
}

class _advicepageState extends State<AdviceScreen> {
  DocumentSnapshot docid;

  _advicepageState({required this.docid});

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
      subject11 = widget.docid.get('question11'); //nerve damage

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

/*
  @override
  Widget build(BuildContext context) {
    advice();
    String note='';
    String  out='';
    String noadvice='';
    final listMap = x.asMap();
    if(x.length>0) {
      for (int i = 0; i < x.length; i++) {
        out = out + listMap[i].toString() + "\n";
      }
      note = note + "** All these Advices should be under the supervision of your doctor";
    }
    else
      noadvice= '** No Advice '+"\n"+"Please check with your Doctor";


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Advice'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 15),

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( note,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20),),
                      ),
                    //  SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( noadvice,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20),),
                      ),
                      //SizedBox(height: 15),
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
              ],
            ),
          ],
        ),
      ),

    );

  }*/

  @override
  Widget build(BuildContext context) {
    advice();
    //String out = '';
    if(x.length==0)
    x.add('No Advice '+"\n"+"Please check with your Doctor"+'\n'+'لا يوجد نصيحة'+'\n'+'يرجى مراجعة طبيبك');

    final listMap = x.asMap();
    /*for (int i = 0; i < x.length; i++) {
      out = out + listMap.toString() + "\n";
    }*/
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title: Text('Advice'),
      ),
      body: StreamBuilder(

        // stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: x.length,
              itemBuilder: (_, index) {
                print("helloooooooooooooooo");
                return GestureDetector(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child : Text( "This Advice should be under the supervision of your doctor ",
                          style: TextStyle(
                              color: Colors.white,
                              backgroundColor:Colors.orange,
                              // fontStyle:,
                              //fontStyle:  ,
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

  void advice()  {

    //1
    if(subject2=='yes'||subject5=='yes'){
      x.add('Advice for Loss of Appetite and Weight Loss: '+'\n'+'Eat food containing these vitamins:'+'\n'+'Zinc, B12, B1'+'\n'
          +'نصائح لفقدان الشهية وفقدان الوزن:' + '\n' + 'تناول الأطعمة التي تحتوي على هذه الفيتامينات:' + '\n' + 'الزنك ، ب 12 ، ب 1');

      // x.add('Eat food containing these vitamins:');
      // x.add('Zinc, B12, B1');
      // x.add("\n");
    }
    if(subject3=='yes'){
      x.add('Advice for Diarrhea: '+'\n'+'Should drink plenty of water, fluids, and foods rich in potassium and pectin. '
          +'\n'+'Avoid fatty foods that contain sugar, caffeine, fiber and dairy products. '+'\n'
          "نصيحة للإسهال:" + "\n" + "يجب شرب الكثير من الماء والسوائل والأطعمة الغنية بالبوتاسيوم والبكتين. "
          + '\n' + 'تجنب الأطعمة الدهنية التي تحتوي على السكر والكافيين والألياف ومنتجات الألبان. '
      );
      // x.add('Should drink plenty of water, fluids, and foods rich in potassium and pectin. ');
      // x.add('Avoid fatty foods that contain sugar, caffeine, fiber and dairy products. ');
      //x.add("\n");
    }
    if(subject4=='yes'){
      x.add('Advice for Vomiting: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B6'+'\n'+
          'نصائح للتقيؤ:' + '\n' + 'تناول الأطعمة التي تحتوي على هذه الفيتامينات:' + '\n' + 'الزنك ، ب 6');
      //x.add('Eat food containing these vitamins:');
      // x.add('B6');
      // x.add("\n");
    }
    if(subject7=='yes'){
      x.add('Advice for Ulcers In Mouth: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, B6'+'\n'+'Mouthwash'+'\n'
          + 'نصيحة للقرحة في الفم:'+ '\n' + 'تناول الأطعمة التي تحتوي على هذه الفيتامينات:' + '\n' + ' ب 12، ب 6'+'\n'+'غسول الفم'
      );
      // x.add('Eat food containing these vitamins:');
      // x.add('B12, B6');
      // x.add('Mouthwash');
      // x.add("\n");
    }
    if(subject9=='yes'){
      x.add('Advice for Poor Memory: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, E, D3, Omega 3'
          +'\n' + 'نصيحة لضعف الذاكرة'+ '\n' + 'تناول الأطعمة التي تحتوي على هذه الفيتامينات:' + '\n' + ' أوميغا 3، ه، ب 12، د 3');
      //x.add('Eat food containing these vitamins:');
      // x.add('B12, E, D3, Omega 3');
      // x.add("\n");
    }
    if(subject10=='yes'){
      x.add('Advice for Anemia: '+'\n'+'Eat food containing these vitamins:'+'\n'+'Iron, B12, folic acid, C'+'\n'+'Please Check with your doctor'
          +'\n' + 'نصائح لفقر الدم:'+ '\n' + 'تناول الأطعمة التي تحتوي على هذه الفيتامينات:' + '\n' + 'الحديد ، ب 12 ، حمض الفوليك ،ج'
          +'\n'+'يرجى مراجعة طبيبك');
      // x.add('Eat food containing these vitamins:');
      //  x.add('Iron, B12, folic acid, C');
      //  x.add('Please Check with your doctor');
      //  x.add("\n");
    }
    if(subject11=='yes'){
      x.add('Advice for Nerve Damage: '+'\n'+'Eat food containing these vitamins:'+'\n'+'B12, Omega 3, B1, B2, B6'
          +'\n'+'نصائح لتلف العصب:'+ '\n' + ':تناول الأطعمة التي تحتوي على هذه الفيتامينات' + '\n' + ' ب 12، ب 1، ب 2، ب3، ب 6، أوميغا 3' );
      // x.add('Eat food containing these vitamins:');
      // x.add('B12, Omega 3, B1, B2, B6, B12');
      //  x.add("\n");
    }
    /*if(subject2=='no'&&subject5=='no'&&subject3=='no'&&subject4=='no'&&subject7=='no'&&subject9=='no'&&subject10=='no'&&subject11=='no') {
      x.add('No Advice ');
    }*/
  }
}