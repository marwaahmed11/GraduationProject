import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/report/report.dart';
import 'package:project/ui/screens/questionnaire_screen.dart';
import '../../main.dart';
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
/*
class addnote extends StatelessWidget {

  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  int group =1;

  TextEditingController name= TextEditingController();
  TextEditingController subject2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {

              ref.add({
                'name': subject2.text,
                'question2': subject2.text,

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
                controller: subject2,
                maxLines: null,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Do you suffer from loss of appetite?"
                      "هل تعاني من فقدان الشهية؟",
                ),
              ),
            ),

            RadioListTile(
                title: const Text('None'),
                value: 'None',
                groupValue: subject2,
                onChanged: (TextEditingController value) {
                  //setState(() {
                   subject2 = value;
               //   });
                  //_showToast('Changed value of Radio[Box] to $value');
                }),




          ],
        ),
      ),
    );
  }
}

*/

class addreport extends StatefulWidget {

  @override
  _addreportState createState() => _addreportState();
}

class _addreportState extends State<addreport> {


  _addreportState();
  @override
  void initState() {

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //////////////////////////////////////////////
  //String name='';
  TextEditingController name = TextEditingController();
  String? _radioBoxValue1 = '';
  String? _radioBoxValue2 = '';
  String? _radioBoxValue3 = '';
  String? _radioBoxValue4 = '';
  String? _radioBoxValue5 = '';
  String? _radioBoxValue6 = '';
  String? _radioBoxValue7 = '';
  String? _radioBoxValue8 = '';
  String? _radioBoxValue9 = '';
  String? _radioBoxValue10 = '';
  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 11, 133),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'name':  name.text,
                'question1': _radioBoxValue1,
                'question2': _radioBoxValue2,
                'question3': _radioBoxValue3,
                'question4': _radioBoxValue4,
                'question5':_radioBoxValue5,
                'question6': _radioBoxValue6,
                'question7': _radioBoxValue7,
                'question8': _radioBoxValue8,
                'question9': _radioBoxValue9,
                'question10': _radioBoxValue10

              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [////////
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

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


                _GroupText("Do you suffer from hair loss?"
                    "هل تعاني من فقدان سقوط الشعر؟"),

                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue1,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value.toString();
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from loss of appetite?"
                    "هل تعاني من فقدان الشهية؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue2,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue2,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue2,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "Do you suffer from diarrhea?"
                    "هل تعاني من الاسهال؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue3,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue3,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue3,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from vomiting?"
                    "هل تعاني من القئ؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue4,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue4,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue4,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from weight loss?"
                    "هل تعاني من فقدان الوزن؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue5,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue5,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue5,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from changes in the nails and skin?"
                    "هل تعاني من تغيرات في الأظافر والجلد؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue6,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue6,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue6,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from changes in ulcers in the mouth?"
                    "هل تعاني من تغيرات تقرحات في الفم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue7,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue7,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue7,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from vaginal dryness?"
                    "هل تعاني من جفاف مهبلي؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue8,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue8,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue8,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "Do you suffer from poor memory?"
                    "هل تعاني من ضعف في الذاكرة؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue9,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue9,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue9,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            _SpaceLine(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("Do you suffer from anemia?"
                    "هل تعاني من فقر الدم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue10,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue10,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue10,
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value of Radio[Box] to $value');
                    }),
              ],
            ),
            // TextField
            // DateTimePicker
            SizedBox(
              height: 50,
            ),


          ],
        ),
      ),
    );
  }







  void _showToast(String text) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(seconds: 1),
    ));
  }
}

class _GroupText extends StatelessWidget {
  final String text;

  const _GroupText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        text,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SpaceLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }
}