import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  // int _selectedItemIndex = 2;
  List data;
  String doctorname = "";
  //List data2;

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final doctor = prefs.getString('doctor') ?? '';
    String baseurl = 'http://localhost/';
    String endpoint = 'info/DoctorBook?doctorid=' + token + '&mode=0';
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
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            color: Color(0XFFA2CBFC),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          doctorname == null ? "" : "Hi " + doctorname,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF343E87)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "Your Appointment Patient List",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.blueGrey),
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
          Positioned(
            top: 180,
            height: MediaQuery.of(context).size.height - 170,
            child: Column(
              children: [
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "  Patient List",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
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
                              margin: EdgeInsets.only(bottom: 15),
                              //  padding: EdgeInsets.all(10),
                              height: 100,
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
                                      Container(
                                        height: 40,
                                        width: 40,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data[index]["Name"][0],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index]["Name"],
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
                                                Icons.phone,
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                '+91' +
                                                    data[index]["MobileNo"]
                                                        .toString(),
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
                                                color: Colors.grey,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                data[index]["Address"] +
                                                    ', ' +
                                                    data[index]["District"] +
                                                    ', ' +
                                                    data[index]["State"],
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
