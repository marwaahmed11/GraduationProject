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
  /*var name;
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
  var subject11;*/
  List<String> subject = [];
  supportMessage message=new supportMessage();

  @override
  void initState() {

    setState(() {
      date=widget.docid.get('date');
      uid= widget.docid.get('uid');
      subject.add(widget.docid.get('Name'));
      subject.add(widget.docid.get('Hair_loss')); //hair loss
      subject.add(widget.docid.get('Loss_of_appetite')); //loss of appetite
      subject.add(widget.docid.get('Diarrhea')); //diarrhea
      subject.add(widget.docid.get('Vomiting')); //vomiting
      subject.add(widget.docid.get('Weight_loss')); //weight loss
      subject.add(widget.docid.get('Changes_in_skin')); //changes in skin
      subject.add(widget.docid.get('Ulcers_in_mouth')); //ulcers in mouth
      subject.add(widget.docid.get('Vaginal_dryness')); //vaginal dryness
      subject.add(widget.docid.get('Poor_memory')); //poor memory
      subject.add(widget.docid.get('Anemia')); //anemia
      subject.add(widget.docid.get('Nerve_damage')); //nerve damage
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
                            subject[0],
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
                            subject[1],
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
                            subject[2],
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
                            subject[3],
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
                            subject[4],
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
                            subject[5],
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
                            subject[6],
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
                            subject[7],
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
                            subject[8],
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
                            subject[9],
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
                            subject[10],
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
                            subject[11],
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