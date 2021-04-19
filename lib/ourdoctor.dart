import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OurDoctorPage extends StatefulWidget {
  @override
  _OurDoctorPageState createState() => _OurDoctorPageState();
}

class _OurDoctorPageState extends State<OurDoctorPage> {
  List data;

  Future<String> getData() async {
    // var response = await http.get(
    //     Uri.encodeFull("http://13.127.50.115:1995/info/Doctor"),
    //     headers: {"Accept": "application/json"});
    var response =
        await http.get(Uri.parse('http://13.127.50.115:1995/info/Doctor'));

    this.setState(() {
      data = json.decode(response.body);
    });

    // var response =
    //     await http.get(Uri.https('http://13.127.50.115:1995/info', 'Doctor'),
    //         headers: <String, String>{
    //           'Content-Type': 'application/json; charset=UTF-8',
    //         },
    //         body: data);

    print(data[0]["doctorid"]);
    print(data[0]["doctor"]);

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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          alignment: Alignment.topCenter,
          color: Color(0XFFA2CBFC),
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.medical_services, color: Color(0XFF263064)),
                  SizedBox(
                    width: 15,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Our",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Color(0XFF263064),
                          fontSize: 22,
                        ),
                        children: [
                          TextSpan(
                            text: " Doctor",
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
        Container(
          child: new Positioned(
            top: 130,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  height: MediaQuery.of(context).size.height - 160,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
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
                              // top: 120,
                              child: Container(
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    new SizedBox(
                                      height: 20,
                                    ),
                                    new Container(
                                      height: 170,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.white),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(.03),
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                            offset: Offset(0, 7),
                                          ),
                                        ],
                                      ),
                                      margin: new EdgeInsets.only(
                                          right: 8, left: 8),
                                      padding:
                                          new EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          new Text(
                                            data[index]["Department"] == null
                                                ? ""
                                                : data[index]["Department"],
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Color(0XFF263064),
                                            ),
                                          ),
                                          new SizedBox(
                                            height: 15,
                                          ),
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new CircleAvatar(
                                                radius: 22,
                                                backgroundImage:
                                                    new NetworkImage(data[index]
                                                                ["PhotoName"] ==
                                                            null
                                                        ? ""
                                                        : data[index]
                                                            ["PhotoName"]),
                                              ),
                                              new SizedBox(
                                                width: 5,
                                              ),
                                              new Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    data[index]["Doctor"] ==
                                                            null
                                                        ? ""
                                                        : data[index]["Doctor"],
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0XFF263064),
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    height: 5,
                                                  ),
                                                  new Container(
                                                    width: 230,
                                                    child: new Text(
                                                      data[index]["Profile"] ==
                                                              null
                                                          ? ""
                                                          : data[index]
                                                              ["Profile"],
                                                      style: TextStyle(
                                                        // fontStyle:
                                                        //     FontStyle.italic,
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          new SizedBox(
                                            height: 15,
                                          ),
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              new SizedBox(
                                                width: 5,
                                              ),
                                              new Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    data[index]["AvailableDays"] ==
                                                            null
                                                        ? ""
                                                        : data[index]
                                                            ["AvailableDays"],
                                                    style: new TextStyle(
                                                      fontSize: 13,
                                                      // fontStyle:
                                                      //     FontStyle.italic,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    height: 5,
                                                  ),
                                                  new Container(
                                                    width: 290,
                                                    child: Text(
                                                      data[index]["ProfileDescription"] ==
                                                              null
                                                          ? ""
                                                          : data[index][
                                                              "ProfileDescription"],
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        // fontStyle:
                                                        //     FontStyle.italic,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
          ),
        )
      ],
    );
  }
}
