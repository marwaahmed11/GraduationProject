import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../report/report.dart';
import '../screens/newhelper_screen.dart';

class edithelper extends StatefulWidget {
  DocumentSnapshot docid;
  String uid;
  edithelper({required this.docid,required this.uid});


  @override
  _edithelperState createState() => _edithelperState(docid: docid,uid:uid);
}

class _edithelperState extends State<edithelper> {
  DocumentSnapshot docid;
  String uid;
  _edithelperState({required this.docid,required this.uid});
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();
  TextEditingController toEmail = TextEditingController();


  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemarks); //////////send location
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});


  }
  void getlocation() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
   GetAddressFromLatLong(position) ;
    //customLaunch('mailto:your@email.com?subject=test%20subject&body=test%20body');
    //final url ='mailto:$toEmail?subject=$emergency&body=$Address';

}





  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('firstname'));
    subject1 = TextEditingController(text: widget.docid.get('lastname'));
    subject2 = TextEditingController(text: widget.docid.get('number'));
    toEmail = TextEditingController(text: widget.docid.get('email'));
    getlocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 0, 11, 133),
        title:Text('Edit'),
        actions: [
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
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'firstname': name.text,
                'lastname': subject1.text,
                'number': subject2.text,
                'email': toEmail.text
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HelperScreen()));
              });
            },
            child: Text(
              "Delete",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                  controller: toEmail,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Text('${Address}'),
              ElevatedButton(
                    onPressed: () async{
                      getlocation();
                      String number = subject2.text;
                      String x = Address;
                      final url='sms:$number?body=$x';
                      customLaunch(url);

                    },

                  child: Text('Send Location')),
              //Text('${Address}'),

            ],
          ),
        ),
      ),
    );
  }

}


