import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleListPage extends StatefulWidget {
  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  List data;
  String doctorname = "";
  String doctorimage = "";

  Future<String> getData() async {
    String baseurl = 'http://13.127.50.115:1995/';

    final prefs = await SharedPreferences.getInstance();
    final doctor = prefs.getString('doctor') ?? '';
    final token = prefs.getString('token') ?? '';
    final mode = "0";
    final doctorimageurl = prefs.getString('doctorimageurl') ?? '';
    String endpoint = 'info/DoctorBook?doctorid=' + token + '&mode=' + mode;
    String url = baseurl + endpoint;
    // var response = await http
    //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var response = await http.get(Uri.parse(url));

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
              color: Color(0XFFA2CBFC),
              gradient: LinearGradient(
                  colors: [
                    Color(0XFFA2CBFC),
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          padding: EdgeInsets.only(left: 25, right: 30, top: 35),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(Icons.book, color: Color(0XFF263064)),
                  SizedBox(
                    width: 15,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Appointment",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0XFF263064),
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: " Book ",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 130,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: MediaQuery.of(context).size.height - 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFF9F9FB),
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
                  height: 130,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(.03),
                        blurRadius: 3,
                        spreadRadius: 2,
                        offset: Offset(0, 7),
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
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF58A2FA)),
                          ),
                          Text(
                            data[index]["AppointTimeAMPM"],
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF58A2FA)),
                          ),
                        ],
                      ),
                      Container(
                        height: 100,
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
                            ),
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
                                width: MediaQuery.of(context).size.width - 160,
                                child: Text(
                                  data[index]["AppointDate"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
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
