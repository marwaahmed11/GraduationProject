import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;


  UserModel({this.uid, this.email, this.firstName, this.secondName});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
    };
  }

/*
  Future<String?> addCollection( )async{
    CollectionReference users=FirebaseFirestore.instance.collection('newuser');
    var result = await users.add({
      'uid':uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,

    });
    await addMultipleCollections (
        id: result.id
    );
    return 'Created';
  }

  Future<String?> addMultipleCollections({String? id })async{

    CollectionReference users=FirebaseFirestore.instance.collection('newuser');
    users.doc(id).collection('newhelper').add({
      'helperid':id,
      //'Created_at' : DateTime.now()
    });
    return 'success';

  }
*/




}