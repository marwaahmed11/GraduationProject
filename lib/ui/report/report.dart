import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../supportmessage.dart';

class reportt extends StatefulWidget {
  String uid='';
  DocumentSnapshot docid;
  reportt({required this.docid,required this.uid});
  @override
  State<reportt> createState() => _reporttState(docid: docid,uid:uid);
}

class _reporttState extends State<reportt> {
  DocumentSnapshot docid;
  String uid='';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getCurrentUser() async {
    User? user = await _auth.currentUser;
    uid = user!.uid;}

  _reporttState({required this.docid,required this.uid});
  final pdf = pw.Document();
  var date;
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

  supportMessage message=new supportMessage();

  @override
  void initState() {

    setState(() {
      date=widget.docid.get('date');
      uid= widget.docid.get('uid');
      name = widget.docid.get('name');
      subject1 = widget.docid.get('question1');
      subject2 = widget.docid.get('question2');
      subject3 = widget.docid.get('question3');
      subject4 = widget.docid.get('question4');
      subject5 = widget.docid.get('question5');
      subject6 = widget.docid.get('question6');
      subject7 = widget.docid.get('question7');
      subject8 = widget.docid.get('question8');
      subject9 = widget.docid.get('question9');
      subject10 = widget.docid.get('question10');
      subject11 = widget.docid.get('question11');

    });
    super.initState();
    getCurrentUser();

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
    return PdfPreview(
      maxPageWidth: 1000,
      canChangeOrientation: false,
      canDebug: false,

      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {

    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final font1 = await PdfGoogleFonts.openSansLight();
    final font2 = await PdfGoogleFonts.openSansLight();

    String? _logo = await rootBundle.loadString('assets/r2.svg');

    doc.addPage(
        pw.MultiPage(
            margin: pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return <pw.Widget>[
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisSize: pw.MainAxisSize.max,
                    children: [
                      pw.Center(
                        child: pw.Text(
                          'Cancer Health Support'+"\n"+
                              "              Report",
                          style: pw.TextStyle(
                            fontSize: 50,
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        height: 20,
                      ),

                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'Created date : ',
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            date,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      pw.Divider(),
                      pw.SizedBox(
                        height: 20,
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            ' Name : ',
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            name,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Hair loss :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject1,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Loss of appetite :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject2,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Diarrhea :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject3,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Vomiting :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject4,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Weight loss :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject5,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Changes in skin :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject6,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Ulcers in mouth :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject7,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Vaginal dryness :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject8,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Poor memory :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject9,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Anemia :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject10,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Nerve damage :",
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          pw.Text(
                            subject11,
                            style: pw.TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(
                        height: 40,
                      ),

                    ],

                ),
              ];
            })
    );
    Expanded(
      child: SingleChildScrollView(
        ),
      );

    return doc.save();
  }
}