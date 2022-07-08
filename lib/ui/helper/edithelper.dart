import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../supportmessage.dart';
import '../screens/helper_screen.dart';
import '../widgets/original_button.dart';

class edithelper extends StatefulWidget {
  DocumentSnapshot docid;
  String uid;
  edithelper({required this.docid,required this.uid});


  @override
  _edithelperState createState() => _edithelperState(docid: docid,uid:uid);
}

class _edithelperState extends State<edithelper> {
  final _formKey = GlobalKey<FormState>();
  DocumentSnapshot docid;
  String uid;
  _edithelperState({required this.docid,required this.uid});
  TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  TextEditingController subject2 = TextEditingController();

  supportMessage message=new supportMessage();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('firstname'));
    subject1 = TextEditingController(text: widget.docid.get('lastname'));
    subject2 = TextEditingController(text: widget.docid.get('number'));

    getlocation();
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

  String location = 'Null, Press Button';
  String Address = 'search';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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


}

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  void actionPopUpItemSelected(String value, String name2) {
    String message;
    if (value == 'save') {
      message = 'You selected save for $name2';
      if (_formKey.currentState!.validate())
        {
        widget.docid.reference.update({
          'firstname': name.text,
          'lastname': subject1.text,
          'number': subject2.text,

        }).whenComplete(() {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HelperScreen()));
        });
    }//if

      // You can navigate the user to edit page.
    }
    else if (value == 'delete') {
      message = 'You selected delete for $name2';
      widget.docid.reference.delete().whenComplete(() {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) =>  HelperScreen()));
      });

    }else {
      message = 'Not implemented';
    }
    print(message);
  }

 String name2='';
  @override
  Widget build(BuildContext context) {
    getlocation();
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
        title:Text('Confirm Helper'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
          itemBuilder: (context) {
            return [
            PopupMenuItem(
              value: 'save',
              child: Text('Save'),
            ),
            PopupMenuItem(
              value: 'delete',
                  child: Text('Delete'),
            )
            ];
          },
          onSelected: (String value){
          print('You Click on po up menu item');
          actionPopUpItemSelected(value, name2);
          },
          ),
              ],

      ),
      body: SingleChildScrollView (
      child: Form(
        key:_formKey,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: 'First Name',
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
                    if(value!.isEmpty)
                    {
                      print (value);
                      return "Last Name is Empty!";
                    }
                    else
                    {
                      subject1.text=value;
                      print(value);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextFormField(
                  controller: subject2,
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Number',
                  ),
                  validator : (value)
                  {
                    if(value!.isEmpty || value.length<11)
                    {
                        return "Number is Empty! or less than 11 digit";
                    }
                    else
                    {
                      subject2.text=value;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 20,
              ),
              Hero(
                tag: 'logoAnimation',
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OriginalButton(
                  text: 'Send Location',
                  color: Colors.pink.shade200,
                  textColor: Colors.white,
                  onPressed: () async{
                    getlocation();
                    String number = subject2.text;
                    String x = name.text+",please help me in this location "+Address;
                    final url='sms:$number?body=$x';
                    customLaunch(url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}


