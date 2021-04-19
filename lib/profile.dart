import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<List<Profile>> fetchProfiles(http.Client client) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  String baseurl = 'http://13.127.50.115:1995/';
  String endpoint = 'info/DoctorLogin?doctorid=';
  String url = baseurl + endpoint + token;
  //final response = await client.get(url);
  final response = await http.get(Uri.parse(url));

  // Use the compute function to run parseProfiles in a separate isolate.
  return compute(parseProfiles, response.body);
}

// A function that converts a response body into a List<Profile>.
List<Profile> parseProfiles(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Profile>((json) => Profile.fromJson(json)).toList();
}

class Profile {
  final String doctorid;
  final String doctor;
  final String doctorimageurl;
  final String starttime;
  final String endtime;
  final String appointno;
  final String upcomingappointno;
  final String department;
  final String profile;
  final String profiledescription;
  final String mobileno;

  Profile(
      {this.doctorid,
      this.doctor,
      this.doctorimageurl,
      this.starttime,
      this.endtime,
      this.appointno,
      this.upcomingappointno,
      this.department,
      this.profile,
      this.profiledescription,
      this.mobileno});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      doctorid: json['doctorid'] as String,
      doctor: json['doctor'] as String,
      doctorimageurl: json['doctorimageurl'] as String,
      starttime: json['starttime'] as String,
      endtime: json['endtime'] as String,
      appointno: json['appointno'] as String,
      upcomingappointno: json['upcomingappointno'] as String,
      department: json['department'] as String,
      profile: json['profile'] as String,
      profiledescription: json['profiledescription'] as String,
      mobileno: json['mobileno'] as String,
    );
  }
}

//void main() => runApp(MyApp());

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

SharedPreferences sharedPreferences;

@override
void initState() async {
  SharedPreferences sharedPreferences;
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('token', 'null');
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: FutureBuilder<List<Profile>>(
          future: fetchProfiles(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ProfilesList(profiles: snapshot.data)
                : Center(child: SpinKitChasingDots(color: Color(0XFFA2CBFC)));

            //    SpinKitWave(
            //       color: Color(0XFFA2CBFC), type: SpinKitWaveType.start),
            // );
          },
        ),
      ),
    );
  }
}

class ProfilesList extends StatelessWidget {
  final List<Profile> profiles;

  ProfilesList({Key key, this.profiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Stack(
          children: <Widget>[
            ClipPath(
              child: Center(child: Container(color: Color(0XFFA2CBFC))),
              clipper: getClipper(),
            ),
            Container(
              child: Positioned(
                  width: 350.0,
                  // color: Colors.black,
                  top: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            // color: Colors.black,
                            image: DecorationImage(
                                image: NetworkImage(
                                  profiles[0].doctorimageurl,
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(95.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1))
                            ]),
                      ),
                      SizedBox(height: 90.0),
                      Text(
                        profiles[0].doctor,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue[900],
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        profiles[0].department,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            // fontStyle: FontStyle.italic,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        profiles[0].profile,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '+91 ' + profiles[0].mobileno,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
