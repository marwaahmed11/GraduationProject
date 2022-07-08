import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_questions/conditional_questions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project/ui/screens/settings_screen.dart';
import '../../supportmessage.dart';
import '../authentication/resetpassword_screen.dart';

class editUserScreen extends StatefulWidget {
  DocumentSnapshot docid;
  String uid;
  editUserScreen({required this.docid,required this.uid});


  @override
  _editUserScreenState createState() => _editUserScreenState(docid: docid,uid:uid);
}

class _editUserScreenState extends State<editUserScreen> {
  final _formKey = GlobalKey<FormState>();
  DocumentSnapshot docid;
  String uid;
  _editUserScreenState({required this.docid,required this.uid});
  TextEditingController name = TextEditingController();
  TextEditingController name2 = TextEditingController();
  TextEditingController toEmail = TextEditingController();

  supportMessage message=new supportMessage();

  @override
  void initState() {
    name = TextEditingController(text: widget.docid.get('firstName'));
    name2 = TextEditingController(text: widget.docid.get('secondName'));
    toEmail = TextEditingController(text: widget.docid.get('email'));

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SettingPage(title: '',)));

          },
        ),
        title:Text('Edit Profile'),
        automaticallyImplyLeading: false,
        actions: [
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()){
              widget.docid.reference.update({
                'firstName': name.text,
                'secondName': name2.text,
                'email': toEmail.text
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) =>  SettingPage(title: '',)));
              });
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
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
                  controller: name2,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator : (value)
                  {
                    if(value!.isEmpty)
                    {
                      return "Last Name is Empty!";
                    }
                    else
                    {
                      name2.text=value;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextFormField(
                  controller: toEmail,
                  maxLines: null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator : (value)
                  {
                    if(value!.isEmpty || !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                    {
                      print (value);
                      return "Email is Empty or invalid!";
                    }
                    else
                    {
                      toEmail.text=value;
                      print(value);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Do you to change Password? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ResetScreen()));
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.pink[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}


