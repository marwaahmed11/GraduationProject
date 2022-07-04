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
      subject1 = widget.docid.get('question1');//hair loss
      subject2 = widget.docid.get('question2');//loss of appetite
      subject3 = widget.docid.get('question3');//diarrhea
      subject4 = widget.docid.get('question4');//vomiting
      subject5 = widget.docid.get('question5');//weight loss
      subject6 = widget.docid.get('question6');//changes in skin
      subject7 = widget.docid.get('question7');//ulcers in mouth
      subject8 = widget.docid.get('question8');//vaginal dryness
      subject9 = widget.docid.get('question9');//poor memory
      subject10 = widget.docid.get('question10');//anemia
      subject11 = widget.docid.get('question11');//nerve damage

    });

    if(subject1=='None' || subject1=='')
    {
      subject1='no';
    }
    else {
      subject1 = 'yes';
    }

    if(subject2=='None' || subject2=='')
    {
      subject2='no';
    }
    else
      subject2='yes';

    if(subject3=='None' || subject3=='')
    {
      subject3='no';
    }
    else
      subject3='yes';

    if(subject4=='None' || subject4=='')
    {
      subject4='no';
    }
    else
      subject4='yes';

    if(subject5=='None' || subject5=='')
    {
      subject5='no';
    }
    else
      subject5='yes';

    if(subject6=='None' || subject6=='')
    {
      subject6='no';
    }
    else
      subject6='yes';
    if(subject7=='None' || subject7=='')
    {
      subject7='no';
    }
    else
      subject7='yes';
    if(subject8=='None' || subject8=='')
    {
      subject8='no';
    }
    else
      subject8='yes';

    if(subject9=='None' || subject9=='')
    {
      subject9='no';
    }
    else
      subject9='yes';

    if(subject10=='None' || subject10=='')
    {
      subject10='no';
    }
    else
      subject10='yes';
    super.initState();
  }

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

  }

  void advice()  {
    // subject1 //hair loss
    // subject2 //loss of appetite
    // subject3 //diarrhea
    // subject4 //vomiting
    // subject5 //weight loss
    // subject6 //changes in skin
    // subject7 //ulcers in mouth
    // subject8 //vaginal dryness
    // subject9 //poor memory
    // subject10 //anemia
    // subject11 //nerve damage
    //1
    if(subject2=='yes'||subject5=='yes'){
      x.add('Advice for Loss of Appetite and Weight Loss: ');
      x.add('Eat food containing these vitamins:');
      x.add('Zinc, B12, B1');
      x.add("\n");
    }
    if(subject3=='yes'){
      x.add('Advice for Diarrhea: ');
      x.add('Should drink plenty of water, fluids, and foods rich in potassium and pectin. ');
      x.add('Avoid fatty foods that contain sugar, caffeine, fiber and dairy products. ');
      x.add("\n");
    }
    if(subject4=='yes'){
      x.add('Advice for Vomiting: ');
      x.add('Eat food containing these vitamins:');
      x.add('B6');
      x.add("\n");
    }
    if(subject7=='yes'){
      x.add('Advice for Ulcers In Mouth: ');
      x.add('Eat food containing these vitamins:');
      x.add('B12, B6');
      x.add('Mouthwash');
      x.add("\n");
    }
    if(subject9=='yes'){
      x.add('Advice for Poor Memory: ');
      x.add('Eat food containing these vitamins:');
      x.add('B12, E, D3, Omega 3');
      x.add("\n");
    }
    if(subject10=='yes'){
      x.add('Advice for Anemia: ');
      x.add('Please Check with your doctor');
      x.add('Eat food containing these vitamins:');
      x.add('Iron, B12, folic acid, C');
      x.add("\n");
    }
    if(subject11=='yes'){
      x.add('Advice for Nerve Damage: ');
      x.add('Eat food containing these vitamins:');
      x.add('B12, Omega 3, B1, B2, B6, B12');
      x.add("\n");
    }
    if(subject2=='no'&&subject5=='no'&&subject3=='no'&&subject4=='no'&&subject7=='no'&&subject9=='no'&&subject10=='no'&&subject11=='no') {
      x.add('No Advice');

    }
  }
}

