import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/main.dart';
import 'package:project/ui/screens/Email_screen.dart';
import 'package:project/ui/screens/questionnaire_screen.dart';
import 'package:project/ui/screens/alert_screen.dart';
import 'package:project/ui/widgets/original_button.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
    title: "Event",
    subtitle: "March, Wednesday",
    event: "3 Events",
    screen:'alert' ,
    img: "assets/images/calendar.png",

  );

  Items item2 = new Items(
    title: "Email",
    subtitle: "send email",
    event: "4 Items",
    screen: 'email' ,
    img: "assets/images/email.png",

  );
  Items item3 = new Items(
    title: "Locations",
    subtitle: "maps",
    event: "",
    screen: 'location' ,
    img: "assets/images/map.png",
  );

  Items item4 = new Items(
    title: " Questionnaire",
    subtitle: "Answer Questionnaire ",
    event: "4 Items",
    screen: 'questionnaire' ,
    img: "assets/images/todo.png",
  );
  Items item5 = new Items(
    title: "Helper",
    subtitle: "",
    event: "",
    screen : 'newhelper',
    img: "assets/images/helper.jpg",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    screen : 'alert',
    img: "assets/images/setting.png",
  );

  @override
  Widget build(BuildContext context) {

    List<Items> myList = [item1,item2, item3,item4, item5,item6];
    var color = 0xFF03A9F4;
    return Flexible(

      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
             onTap: (){
               /* Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => QuestionnairePage(title: '')//you can send parameters using constructor
                    ));
                //Are there another way to send parameters ? Yes !, Use RouteNames
                Navigator.pushNamed(context, '/questionnaire');*/
               Navigator.pushNamed(context,data.screen);

              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.event,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );

          }).toList()),
    );
  }
}


class Items {
  final String title;
  final String subtitle;
  final String event;
  final String img;
 // final BuildContext screen ;
  final String screen;

  const Items( {required this.title, required this.subtitle, required this.event ,required this.screen,required this.img});

}

