import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentPatientListPage extends StatefulWidget {
  @override
  _CurrentPatientListPageState createState() => _CurrentPatientListPageState();
}

class _CurrentPatientListPageState extends State<CurrentPatientListPage> {
  // int _selectedItemIndex = 2;
  List data;
  String doctorname = "";
  //List data2;

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final doctor = prefs.getString('doctor') ?? '';
    String baseurl = 'http://localhost/';
    String endpoint = 'info/MedCurrentPatient?doctorid=' + token;
    String url = baseurl + endpoint;
    // var response = await http
    //     .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var response = await http.get(Uri.parse(url));

    this.setState(
      () {
        data = json.decode(response.body);
        doctorname = doctor == null ? "" : doctor;
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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5, right: 30, top: 30),
            color: Color(0XFFA2CBFC),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Color(0XFF263064)),
                            SizedBox(
                              width: 15,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: "Current",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Color(0XFF263064),
                                    fontSize: 22,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: " Patient",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 130,
            height: MediaQuery.of(context).size.height - 130,
            child: Column(
              children: [
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      // Text(
                      //   " Current Patient List",
                      //   style: TextStyle(
                      //       fontSize: 15,
                      //       fontWeight: FontWeight.w400,
                      //       color: Colors.grey),
                      // ),
                      SizedBox(
                        height: 0,
                      ),
                      Expanded(
                        child: new ListView.builder(
                          itemCount: data == null ? 0 : data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //start
                            //start
                            //start
                            //start
                            return new Container(
                              margin: EdgeInsets.only(bottom: 35),
                              //  padding: EdgeInsets.all(10),
                              height: 210,
                              padding: EdgeInsets.all(5),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 29,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]["PatientName"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.card_giftcard,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                data[index]["Age"].toString() +
                                                    " Yr",
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.red[900],
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["Address"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.single_bed,
                                                color: Colors.indigo,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "BedNo - " +
                                                    data[index]["BedNo"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: Colors.blue[300],
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["Room"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.book,
                                                color: Colors.green,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["Cases"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.room_preferences,
                                                color: Colors.green,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["Ward"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: Colors.green,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["AdmissionDate"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "IPNo",
                                                style: TextStyle(
                                                    color: Colors.blue[900],
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w900),

                                                // Icons.book,
                                                // color: Colors.green,
                                                // size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["IPNo"],
                                                style: (TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  // Container(
                                  //   height: 45,
                                  //   width: 45,
                                  //   decoration: BoxDecoration(
                                  //     color: Colors.blue.withOpacity(0.2),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Icon(
                                  //     Icons.call,
                                  //     size: 20,
                                  //     color: Color(0XFFA2CBFC),
                                  //   ),
                                  // )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
