import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/ui/screens/symptom_screen.dart';
import '../../supportmessage.dart';

class addreport extends StatefulWidget {

  String uid;
  addreport({required this.uid});
  @override
  _addreportState createState() => _addreportState(uid:uid);
}

class _addreportState extends State<addreport> {

  String uid;
  _addreportState({required this.uid});
  final _formKey = GlobalKey<FormState>();
  supportMessage message=new supportMessage();

  @override
  void initState() {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  String?  _radioBoxValue1 = 'None';
  String? _radioBoxValue2 = 'None';
  String? _radioBoxValue3 = 'None';
  String? _radioBoxValue4 = 'None';
  String? _radioBoxValue5 = 'None';
  String? _radioBoxValue6 = 'None';
  String? _radioBoxValue7 = 'None';
  String? _radioBoxValue8 = 'None';
  String? _radioBoxValue9 = 'None';
  String? _radioBoxValue10 = 'None';
  String? _radioBoxValue11 = 'None';

  String date = DateFormat.yMMMd().format(DateTime.now());


  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Report"),
        backgroundColor: Colors.pink[200],
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>QuestionnaireScreen()));

          },
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
              ref.add({
                'date':date,
                'uid' :uid,
                'Name':  name.text,
                'Hair_loss': _radioBoxValue1,
                'Loss_of_appetite': _radioBoxValue2,
                'Diarrhea': _radioBoxValue3,
                'Vomiting': _radioBoxValue4,
                'Weight_loss':_radioBoxValue5,
                'Changes_in_skin': _radioBoxValue6,
                'Ulcers_in_mouth': _radioBoxValue7,
                'Vaginal_dryness': _radioBoxValue8,
                'Poor_memory': _radioBoxValue9,
                'Anemia': _radioBoxValue10,
                'Nerve_damage': _radioBoxValue11

              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => QuestionnaireScreen()));
              });
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.all(5),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextFormField(
                    controller: name,
                     decoration: InputDecoration(
                         labelText: 'Full Name',
                ),
                    validator : (value)
                    {
                      if(value!.isEmpty)
                      {
                        print (value);
                        return "Full Name is Empty!";
                      }
                      else
                      {
                        name.text=value;
                        print(value);
                      }
                    },
                  ),
                ),

                SizedBox(
                  height: 10,
                ),


                _GroupText("1- Do you suffer from hair loss?"+"\n"+
                    "هل تعاني من سقوط الشعر؟"),

                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue1,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue1 = value.toString();
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("2- Do you suffer from loss of appetite?"+"\n"+
                    "هل تعاني من فقدان الشهية؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue2,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue2 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "3- Do you suffer from diarrhea?"+"\n"+
                    "هل تعاني من الاسهال؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value  to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue3,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue3 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("4- Do you suffer from vomiting?"+"\n"+
                    "هل تعاني من القئ؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue4,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue4 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("5- Do you suffer from weight loss?"+"\n"+
                    "هل تعاني من فقدان الوزن؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue5,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue5 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("6- Do you suffer from changes in the nails and skin?"+"\n"+
                    "هل تعاني من تغيرات في الأظافر والجلد؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue6,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue6 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("7- Do you suffer from changes in ulcers in the mouth?"+"\n"+
                    "هل تعاني من تغيرات تقرحات في الفم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue7,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue7 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("8- Do you suffer from vaginal dryness?"+"\n"+
                    "هل تعاني من جفاف مهبلي؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue8,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue8 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText( "9- Do you suffer from poor memory?"+"\n"+
                    "هل تعاني من ضعف في الذاكرة؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue9,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue9 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("10- Do you suffer from anemia?"+"\n"+
                    "هل تعاني من فقر الدم؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue10,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue10 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
              ],
            ),
            // TextField
            // DateTimePicker

            Divider(
              color: Colors.black12,
              thickness: 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _GroupText("11- Do you suffer from nerve damage?"+"\n"+
                    "هل تعاني من تلف الاعصاب؟"),
                RadioListTile(
                    title: const Text('None'),
                    value: 'None',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
                    }),
                RadioListTile(
                    title: const Text('Mid'),
                    value: 'Mid',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
                    }),

                RadioListTile(
                    title: const Text('Severe'),
                    value: 'Severe',
                    groupValue: _radioBoxValue11,
                    activeColor: Colors.pink[200],
                    onChanged: (String? value) {
                      setState(() {
                        _radioBoxValue11 = value;
                      });
                      _showToast('Changed value to $value');
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
