import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/AddContactpage.dart';
import '../helper/EditPage.dart';
import '../helper/detailpage.dart';
import '../../mainscreen.dart';
import '../../modals/modal.dart';

class HelperScreen extends StatefulWidget {
  const HelperScreen({Key? key}) : super(key: key);

  @override
  State<HelperScreen> createState() => _MyAppState();
}

bool isDark = false;
final ThemeData lighttheme = ThemeData(
  primaryColor: Colors.green,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blueAccent,
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
final ThemeData darktheme = ThemeData(
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
    iconTheme: IconThemeData(color: Colors.blueAccent),
  ),
);

class _MyAppState extends State<HelperScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (val) {
      if (mounted)
        {
          setState(() {});
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lighttheme,
      darkTheme: darktheme,
      themeMode: (isDark == true) ? ThemeMode.dark : ThemeMode.light,
      routes: {
        "/": (context) => HelperPage(),
        "addcontactpage": (context) => const AddContactPage(),
        "detailpage": (context) => const DetailPage(),
        "editpage": (context) => const EditPage(),
      },
    );
  }
}

class HelperPage extends StatefulWidget {
  const HelperPage({Key? key}) : super(key: key);

  @override
  State<HelperPage> createState() => _HelperPageState();
}

class _HelperPageState extends State<HelperPage> {

  MainScreen ms = new MainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("addcontactpage");
        },
      ),
      appBar: AppBar(
        title: Text("Helper"),
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context,'/home');
          },
          icon:const Icon(Icons.arrow_back ,color: Colors.white),
        ),

        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (isDark == true) {
                  isDark = false;
                } else {
                  isDark = true;
                }
                print(isDark);
              });
            },
            child: CircleAvatar(
              radius: 15,
              backgroundColor:
              Theme.of(context).appBarTheme.titleTextStyle!.color,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: Container(
          alignment: Alignment.center,
          child: (contact.isEmpty)
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/open-cardboard-box.png",
                  height: 200),
              const SizedBox(height: 20),
              const Text(
                "You have not helpers yet",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
              : ListView.builder(
            itemCount: contact.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed("detailpage", arguments: contact[i]);
                },
                leading: CircleAvatar(
                  radius: 26,
                  /*backgroundImage: (contact[i].image != null)
                      ? FileImage(contact[i].image!)
                      : null,*/
                ),
                title: Text(
                    "${contact[i].firstname} ${contact[i].lastname}"),
                subtitle: Text("+2 ${contact[i].phone}"),
                trailing: IconButton(
                  icon: const Icon(Icons.call,
                      color: Colors.green, size: 33),
                  onPressed: () async {
                    String url = "tel:+2${contact[i].phone}";

                    await canLaunch(url);

                    await launch(url);
                  },
                ),
              );
            },
          )),
    );
  }
}