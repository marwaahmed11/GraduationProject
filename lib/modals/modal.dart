import 'dart:io';

import 'package:flutter/material.dart';

class Contact
{
  late  final  String? firstname;
  late  final  String? lastname;
  late  final  String? phone;
  late  final  String? email;
  late  final File? image;

  Contact({required this.email,required this.firstname,required this.lastname,required this.image,required this.phone});
}
List<Contact> contact =<Contact>[];