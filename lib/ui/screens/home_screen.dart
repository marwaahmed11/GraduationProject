import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../griddashboard.dart';
import '../../mainscreen.dart';
import '../../services/auth.dart';
import '../widgets/original_button.dart';


/*
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OriginalButton(
                text: 'Add Event',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushNamed('alert');
                },
              ),

            ),
           /* Hero(
              tag: 'logoAnimation',
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OriginalButton(
                text: 'Acess Location',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushNamed('location');
                },
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OriginalButton(
                text: 'Email',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushNamed('email');
                },
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OriginalButton(

                text: 'Answer Questionnaire',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushNamed('questionnaire');
                },
              ),

            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: OriginalButton(
                text: 'Sign Out',
                color: Colors.white,
                textColor: Colors.lightBlue,
                onPressed: () {
                  Navigator.of(context).pushNamed('login');
                },
              ),

            ),


          ],
        ),
      ),
    );
  }
}

*/


class HomeScreen extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<HomeScreen> {

  MainScreen ms = new MainScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 110,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cancer Health Support",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Color(0xFF2196F3),
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                IconButton(
                  alignment: Alignment.topCenter,
                  icon: Image.asset(
                    "assets/images/imggp.png",
                    width: 50,
                  ),
                    onPressed: () {}
                )
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}





