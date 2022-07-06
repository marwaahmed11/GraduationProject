import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
class Person {
  final String uid;
  Person({required this.uid});
}

class AuthBase {
  Person? _userFromFirebase(User user) {
    return user != null ? Person(uid: user.uid) : null;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user=authResult.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user=authResult.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
*/

/*
class Person {
  final String uid;
  Person({required this.uid});
}

class AuthBase {
  Person? _userFromFirebase(User user) {
    return user != null ? Person(uid: user.uid) : null;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user=authResult.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user=authResult.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
*/