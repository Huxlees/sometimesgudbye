import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'todayappointlist.dart';
import 'package:Navigation/upcomingappointmentlist.dart';
import 'pastappointmentlist.dart';
import 'package:flutter/services.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<HomePage> {
  List data;
  String doctorname = "";
  String doctorimage = "";
  String doctorprofile = "";
  String doctorstarttime = "";
  String doctorendtime = "";
  String doctorNoPending = "";
  String doctorNoAppoint = "";

  Future<String> getData() async {
    String baseurl = 'http://13.127.50.115:1995/';

    final prefs = await SharedPreferences.getInstance();
    final doctor = prefs.getString('doctor') ?? '';
    final token = prefs.getString('token') ?? '';

    final mode = "0";
    final doctorimageurl = prefs.getString('doctorimageurl') ?? '';
    final profile = prefs.getString('Profile') ?? '';
    final starttime = prefs.getString('starttime') ?? '';
    final endtime = prefs.getString('endtime') ?? '';
    String endpoint = 'info/DoctorBook?doctorid=' + token + '&mode=' + mode;
    String url = baseurl + endpoint;
    // var response = await http
    //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var response = await http.get(Uri.parse(url));
    if (this.mounted) {
      this.setState(
        () {
          data = json.decode(response.body);
          doctorname = doctor == null ? "" : doctor;
          doctorimage = doctorimageurl == null ? "" : doctorimageurl;
          doctorprofile = profile == null ? "" : profile;
          doctorstarttime = starttime == null ? "" : starttime;
          doctorendtime = endtime == null ? "" : endtime;
          //data[index]["Name"][0],
        },
      );
    }

    return "Success!";
  }

  Future<String> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    String doctorid = prefs.getString('token') ?? '';
    Map data = {'DoctorID': doctorid};
    var jsonResponseNoAp = null;
    // var responseAp = await http
    //     .post("http://13.127.50.115:1995/info/DoctorPatientRecord", body: data);

    var url = Uri.parse('http://13.127.50.115:1995/info/DoctorPatientRecord');
    var responseAp = await http.post(url, body: {'DoctorID': doctorid});

    if (responseAp.statusCode == 200) {
      if (jsonResponseNoAp != null || jsonResponseNoAp != "") {
        jsonResponseNoAp = json.decode(responseAp.body);
        doctorNoAppoint = jsonResponseNoAp["apointedno"].toString() == null
            ? ""
            : jsonResponseNoAp["apointedno"].toString();
        doctorNoPending = jsonResponseNoAp["noappointed"].toString() == null
            ? ""
            : jsonResponseNoAp["noappointed"].toString();
      }
      return "Success!";
    }
  }

  @override
  void initState() {
    this.getData();
    this.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final appcastURL = 'http://13.127.50.115:1995/info/upgrader';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return UpgradeAlert(
      appcastConfig: cfg,
      debugLogging: true,
      child: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xFFD4E7FE), Color(0XFFA2CBFC)]),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
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
                                backgroundImage: doctorimage.isNotEmpty
                                    ? NetworkImage(doctorimage)
                                    : null,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctorname,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF343E87)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.medical_services,
                                      color: Colors.blueGrey,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: doctorprofile,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.grey.shade100,
                    child: ListView(
                      padding: EdgeInsets.only(top: 75),
                      children: [
                        Text(
                          "Activity",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        // SizedBox(
                        //   height: 1,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PastScheduleListPage(),
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 85,
                                width: 85,
                                decoration: BoxDecoration(
                                    color: Colors.indigo.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment_return_outlined,
                                      color: Color(0XFF7F4EF5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Past",
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TodayScheduleListPage())),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment_returned_rounded,
                                      color: Color(0XFF58A9F6),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Today",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UpComingScheduleListPage())),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.cyan.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.drive_file_move_outline,
                                      color: Color(0XFF31c9af),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Upcoming",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "Appointment List",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 155,
                          child: new ListView.builder(
                            itemCount: data == null ? 0 : data.length,
                            itemBuilder: (BuildContext context, int index) {
                              //start
                              //start
                              //start
                              //start
                              return new Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 18),
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                height: 95,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.blue
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  data[index]["Name"][0],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              data[index]["Name"],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              data[index]["Verify"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300,
                                                color:
                                                    data[index]["VerifyID"] == 1
                                                        ? Color(0XFF31c9af)
                                                        : Color(0XFFcccc00),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  " " +
                                                      data[index]
                                                          ["AppointTime"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  data[index]["AppointDate"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 185,
              right: 20,
              left: 20,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                //padding:EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0) ,
                width: MediaQuery.of(context).size.width * 0.85,
                height: 160,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 8,
                        spreadRadius: 3,
                        offset: Offset(0, 10),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Start Time",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.timer,
                                  color: Color(0XFF58A9F6),
                                  size: 15,
                                )
                              ],
                            ),
                            Text(
                              doctorstarttime,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                        Container(width: 1, height: 50, color: Colors.grey),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "End time",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.timer_off_sharp,
                                  color: Color(0XFF58A9F6),
                                  size: 15,
                                )
                              ],
                            ),
                            Text(
                              doctorendtime,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                  color: Colors.black87),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You have " +
                          doctorNoAppoint +
                          " patient approved from App this month",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300
                          //fontStyle: FontStyle.italic,
                          ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "You have " + doctorNoPending + " patient on pending",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300
                          //fontStyle: FontStyle.italic,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      width: double.maxFinite,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
