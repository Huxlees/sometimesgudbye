import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpComingScheduleListPage extends StatefulWidget {
  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<UpComingScheduleListPage> {
  List data;
  String doctorname = "";
  String doctorimage = "";

  Future<String> getData() async {
    String baseurl = 'http://13.127.50.115:1995/';

    final prefs = await SharedPreferences.getInstance();
    final doctor = prefs.getString('doctor') ?? '';
    final token = prefs.getString('token') ?? '';
    final mode = "2";
    final doctorimageurl = prefs.getString('doctorimageurl') ?? '';
    String endpoint = 'info/DoctorBook?doctorid=' + token + '&mode=' + mode;
    String url = baseurl + endpoint;
    // var response = await http
    //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var response = await http.get(Uri.parse(url));
// static String encodeComponent(String component) {
//   return _Uri._uriEncode(_Uri._unreserved2396Table, component, utf8, false);
// }
    this.setState(() {
      data = json.decode(response.body);
      doctorname = doctor == null ? "" : doctor;
      doctorimage = doctorimageurl == null ? "" : doctorimageurl;
    });

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    Color(0XFFA2CBFC),
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 8,
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(doctorimage),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi " + doctorname,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.none,
                          color: Color(0XFF343E87),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Here is a list of upcoming schedule",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "You need to check...",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blueGrey,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 185,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            height: MediaQuery.of(context).size.height - 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                //start
                //start
                //start
                //start
                return new Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(10),
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F9FB),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.05),
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index]["AppointTimeOnly"],
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                              color: Colors.grey,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Text(
                            data[index]["AppointTimeAMPM"],
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 80,
                        width: 1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 160,
                            child: Text(
                              data[index]["Name"],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 130,
                                child: Text(
                                  data[index]["AppointDate"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w100,
                                    fontSize: 11,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(
                                    data[index]["VerifyID"] == 0
                                        ? 0XFFebf1c5
                                        : 0XFFc0e0cb),
                                //  backgroundImage: NetworkImage(
                                //  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=80"),
                                radius: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                data[index]["Verify"],
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w100,
                                    decoration: TextDecoration.none),
                              )
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
        )
      ],
    );
  }
}
