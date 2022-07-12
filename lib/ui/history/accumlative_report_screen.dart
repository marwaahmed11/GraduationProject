import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../supportmessage.dart';

class AccumlativeReport extends StatefulWidget {
  String uid='';
  List<String> x;
  AccumlativeReport({required this.x});
  @override
  State<AccumlativeReport> createState() => _reporttState(list:x);
}

class _reporttState extends State<AccumlativeReport> {

  String uid='';
  List<String> list;
  _reporttState({required this.list});
  final pdf = pw.Document();

  supportMessage message=new supportMessage();

  @override
  void initState() {
    setState(() {

    });
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

    for(int i=0;i<list.length;i++)
      {
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
                        '       History Report ',
                        style: pw.TextStyle(
                          fontSize: 50,
                        ),
                      ),
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),

                    pw.Divider(),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          list[i],
                          style: pw.TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Divider(),
                  ],

                ),
              ];
            })
    );}
    Expanded(
      child: SingleChildScrollView(
      ),
    );

    return doc.save();
  }
}