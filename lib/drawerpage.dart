import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'termandprivacy.dart';
import 'package:flutter/services.dart';

class NavDrawer extends StatefulWidget {
  //String doctorname = "";
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String doctorname = "";
  String doctorimage = "";

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final doctor = prefs.getString('doctor') ?? '';
    final doctorimageurl = prefs.getString('doctorimageurl') ?? '';

    this.setState(
      () {
        doctorname = doctor == null ? "" : doctor;
        doctorimage = doctorimageurl == null ? "" : doctorimageurl;
      },
    );

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
    //this.getData2();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFFEAF3FF), Color(0xFFD4E7FE)]),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFA2CBFC),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 8,
                              spreadRadius: 3)
                        ],
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      padding: EdgeInsets.all(5),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(doctorimage),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      doctorname,
                      style: TextStyle(color: Color(0XFF343E87), fontSize: 19),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFD4E7FE), Color(0XFFA2CBFC)]),
                  // image: DecorationImage(
                  // fit: BoxFit.fill,
                  //  image: AssetImage('assets/images/cover.jpg'))),
                )),
            ListTile(
              leading: Icon(Icons.verified_user, color: Color(0XFF58A9F6)),
              title: Text(
                'Private Policy',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF58A9F6)),
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicy()))
              },
            ),
            ListTile(
              leading: Icon(Icons.article_sharp, color: Color(0XFF58A9F6)),
              title: Text(
                'Term and Condition',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF58A9F6)),
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TermandCondition()))
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Color(0XFF58A9F6)),
              title: Text(
                'Exit',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0XFF58A9F6)),
              ),
              onTap: () => SystemChannels.platform
                  .invokeMethod<void>('SystemNavigator.pop'),
            ),
          ],
        ),
      ),
    );
  }
}
