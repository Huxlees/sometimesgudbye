import 'package:Navigation/profile.dart';
import 'package:flutter/material.dart';
import 'ourdoctor.dart';
import 'package:Navigation/appointmentlist.dart';
import 'home.dart';
import 'package:upgrader/upgrader.dart';
import 'currentpatientlist.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    ScheduleListPage(),
    CurrentPatientListPage(),
    OurDoctorPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appcastURL = 'http://13.127.50.115:1995/info/upgrader';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.grey.shade100,
            unselectedItemColor: Color(0XFFA2CBFC),
            selectedItemColor: Color(0XFF58A9F6),
            selectedIconTheme: IconThemeData(
              color: Color(0XFF58A9F6),
            ),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              if (this.mounted) {
                setState(
                  () {
                    _selectedItemIndex = index;
                  },
                );
              }
            },
            items: [
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.book),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.person_search_sharp),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.person),
              ),
            ],
          ),
          body: // pages[_selectedItemIndex],
              UpgradeAlert(
            appcastConfig: cfg,
            debugLogging: true,
            child: Center(child: pages[_selectedItemIndex]),
          )),
    );
  }
}
