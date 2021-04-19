import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigationpage.dart';
import 'drawerpage.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

String notifyContent = '';
void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new HomeApp(),
      title: new Text(
        'Raj Booking Doctor App',
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: Colors.blue[900]),
      ),
      image: new Image.asset(
        'assets/images/FavIcon.png',
        height: 700,
      ),
      photoSize: 45.0,
      backgroundColor: Color(0xfff0ffff),
      loaderColor: Colors.blue,
      styleTextUnderTheLoader:
          new TextStyle(color: Color(0xff0033ff), fontWeight: FontWeight.w900),
    );
  }
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(accentColor: Colors.white70),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  // int isLog = 0;
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      // isLog = 1;
    }
  }

  @override
  void initState() {
    //super.initState();
    checkLoginStatus();
    configOneSignal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: MediaQuery.of(
              context,
            ).size.width *
            0.08,
        width: MediaQuery.of(context).size.width * 0.2,
        child: FloatingActionButton(
          onPressed: () {
            sharedPreferences.clear();
            sharedPreferences.commit();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
          },
          child: Text(
            "Log Out",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          //  heroTag: "demoValue",
          // icon: Icon(Icons.logout),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: Color(0XFFA2CBFC),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            // isLog == 0
            //     ? SpinKitChasingDots(color: Color(0XFFA2CBFC))
            //     :
            NavigationPage(),
      ),
      drawer: NavDrawer(),
    );
  }

  // OneSignal.shared.setext
  // void addTag() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String doctorid = prefs.getString('token') ?? '';
  //   await OneSignal.shared.sendTag('DoctorID', doctorid);
  // }
  void configOneSignal() async {
    final prefs = await SharedPreferences.getInstance();
    String doctorid = prefs.getString('token') ?? '';
    await OneSignal.shared.init('5ea41584-fb8c-4550-bfa8-99ab5fcf7dd5');

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
    OneSignal.shared.setNotificationReceivedHandler((notification) {
      setState(() {
        notifyContent =
            notification.jsonRepresentation().replaceAll('\\n', '\n');
      });
    });
    await OneSignal.shared.sendTag('DoctorID', doctorid);
  }
}
