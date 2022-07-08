import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/original_button.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String email='';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
          ),
          SizedBox(
            height: 50,

          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: OriginalButton(
              text: 'Send Request',
              color: Colors.pink.shade200,
              textColor: Colors.white,
              onPressed: () {
                auth.sendPasswordResetEmail(email: email);
                Navigator.of(context).pop();

              },
            ),
          ),

        ],),
    );
  }
}