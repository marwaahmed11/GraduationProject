import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../model/user_model.dart';
import '../screens/newhelper_screen.dart';


class addhelper extends StatelessWidget {
  TextEditingController  name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController subject3 = TextEditingController();
  //TextEditingController uid = TextEditingController();
  String uid;
  //UserModel userModel = UserModel();
  //addhelper({required UserModel uid});
  addhelper({required this.uid});

  //User? user = FirebaseAuth.instance.currentUser;


  CollectionReference ref = FirebaseFirestore.instance.collection('helpers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title:Text('Add'),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'uid': uid,
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,
                'email': subject3.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HelperScreen()));
              });
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HelperScreen()));
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
           /* Container(
              //decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: uid,
               /* decoration: InputDecoration(
                  hintText: 'firstname',
                ),*/
              ),
            ),*/

            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: 'firstname',
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
                  hintText: 'lastname',
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
                  hintText: 'number',
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
                  hintText: 'email',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
