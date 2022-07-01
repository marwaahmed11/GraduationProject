import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/screens/questionnaire_screen.dart';
import 'main.dart';
import 'report.dart';
/*
class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('name'));
    subject1 = TextEditingController(text: widget.docid.get('Maths'));
    subject2 = TextEditingController(text: widget.docid.get('Science'));
    subject3 = TextEditingController(text: widget.docid.get('History'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
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
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
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
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color.fromARGB(255, 0, 11, 133),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
/*
class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});
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

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('name'));
    subject1 = TextEditingController(text: widget.docid.get('question1'));
    subject2 = TextEditingController(text: widget.docid.get('question2'));
    subject3 = TextEditingController(text: widget.docid.get('question3'));
    subject4 = TextEditingController(text: widget.docid.get('question4'));
    subject5 = TextEditingController(text: widget.docid.get('question5'));
    subject6 = TextEditingController(text: widget.docid.get('question6'));
    subject7 = TextEditingController(text: widget.docid.get('question7'));
    subject8 = TextEditingController(text: widget.docid.get('question8'));
    subject9 = TextEditingController(text: widget.docid.get('question9'));
    subject10 = TextEditingController(text: widget.docid.get('question10'));


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
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
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
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
              MaterialButton(
                color: Color.fromARGB(255, 0, 11, 133),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});

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


  @override
  void initState() {
    name = widget.docid.get('name');

    subject1 =  widget.docid.get('question1');
    subject2 =  widget.docid.get('question2');
    subject3 =  widget.docid.get('question3');
    subject4 =  widget.docid.get('question4');
    subject5 =  widget.docid.get('question5');
    subject6 =  widget.docid.get('question6');
    subject7 =  widget.docid.get('question7');
    subject8 =  widget.docid.get('question8');
    subject9 =  widget.docid.get('question9');
    subject10 = widget.docid.get('question10');





    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
            },
            child: Text(
              "Back",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          /* MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
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
          ),*/
          /*MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'name': name,
                'question1': subject1,
                'question2': subject2,
                'question3': subject3,
                'question4': subject4,
                'question5': subject5,
                'question6': subject6,
                'question7': subject7,
                'question8': subject8,
                'question9': subject9,
                'question10': subject10

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
          ),*/
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
              });
            },
            child: Text(
              "delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
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
                  'Name',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),

              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from hair loss?"
                      "هل تعاني من فقدان سقوط الشعر؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from loss of appetite?"
                      "هل تعاني من فقدان الشهية؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from diarrhea?"
                      "هل تعاني من الاسهال؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),

                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject3,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from vomiting?"
                      "هل تعاني من القئ؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject4,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from weight loss?"
                      "هل تعاني من فقدان الوزن؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject5,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from changes in the nails and skin?"
                      "هل تعاني من تغيرات في الأظافر والجلد؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject6,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from changes in ulcers in the mouth?"
                      "هل تعاني من تغيرات تقرحات في الفم؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject7,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from vaginal dryness?"
                      "هل تعاني من جفاف مهبلي؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject8,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from poor memory?"
                      "هل تعاني من ضعف في الذاكرة؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject9,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  "Do you suffer from anemia?"
                      "هل تعاني من فقر الدم؟",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child:  Text(
                  subject10,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),



              MaterialButton(
                color: Color.fromARGB(255, 0, 11, 133),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Make Report",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
