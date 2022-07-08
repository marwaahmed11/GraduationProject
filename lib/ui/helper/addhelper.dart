import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../supportmessage.dart';
import '../screens/helper_screen.dart';

class addhelper extends StatefulWidget {

  String uid;
  addhelper({required this.uid});
  @override
  _addhelperState createState() => _addhelperState(uid:uid);
}

class  _addhelperState extends State<addhelper> {
  TextEditingController  name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();

  String uid;

  final _formKey = GlobalKey<FormState>();
  _addhelperState({required this.uid});

  CollectionReference ref = FirebaseFirestore.instance.collection('helpers');

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
             onPressed: () {
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HelperScreen()));
             },
        ),
        automaticallyImplyLeading: false,
        title:Text('New Helper'),
        actions: [
          MaterialButton(
            onPressed: () {
            if (_formKey.currentState!.validate()){
                ref.add({
                'uid': uid,
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,
                }).whenComplete(() {
                Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HelperScreen()));
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator : (value)
                {
                  if(value!.isEmpty)
                  {
                    return "First Name is Empty!";
                  }
                  else
                    {
                      name.text=value;
                    }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextFormField(
                controller: subject1,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                ),
                validator : (value)
                  {
                    if(value==null || value.isEmpty)
                      {
                        return ("Last Name is Empty!");
                      }
                   else
                     {
                       subject1.text=value;
                     }
                  },
              ),
            ),

            SizedBox(
              height: 10,
            ),
        TextFormField(
          autofocus: false,
          keyboardType: TextInputType.number,
          controller: subject2,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Number",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator : (value)
          {
            if(value==null || value=='' || value.length<11)
            {
              return ("Number is Empty! or less than 11 digit");
            }
            else
            {
              subject2.text=value;
            }
          },
        ),
          ],
        ),
      ),
    );
  }
}

