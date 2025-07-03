import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Animation/FadeAnimation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

bool msg = false;
bool ischange = false;
bool issucess = false;
var urls;
Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    urls,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'UserName': title,
    }),
  );

  if (response.statusCode == 200) {
    msg = true;

    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

//@override

class Album {
  final String msgstatus;

  Album({this.msgstatus});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      msgstatus: json['msgstatus'].toString(),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<ForgotPassword> {
  confirm(String email, pass, otp) async {
    var test;
    Map data = {'UserName': email, 'UserPassword': pass, 'OTP': otp};
    var jsonResponse = null;

    final responses =
        await http.post(Uri.https('localhost/info', 'DocPass'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: data);

    if (responses.statusCode == 200) {
      jsonResponse = json.decode(responses.body);
      if (jsonResponse != null) {
        if (this.mounted) {
          setState(
            () {
              issucess = true;
              print(responses.body);
            },
          );
        }
        test = jsonResponse.toString();
        //ischange = true;

      }
    }

    //return "Success";
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  Future<Album> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Reset Password',
        //     style: TextStyle(color: Colors.blueAccent),
        //   ),
        //   backgroundColor: Color(0xFFD4E7FE),
        // ),
        body: Container(
          alignment: Alignment.center,
          // padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null)
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        height: 70,
                        child: FadeAnimation(
                          1.6,
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                child: Center(
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Center(
                                  child: Text(
                                    "Please use your  registered gmail account",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Container(
                        height: 60,
                        width: 310,
                        child: FadeAnimation(
                          1.6,
                          Column(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(top: 2, left: 10, right: 4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.cyan.withOpacity(0.1),
                                          blurRadius: 10.0,
                                          offset: Offset(0, 6))
                                    ]),
                                child: TextFormField(
                                  controller: _controller,
                                  //maxLines: null,
                                  keyboardType: TextInputType.emailAddress,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // child:
                        child: FadeAnimation(
                          1.6,
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 47.0,
                                padding: EdgeInsets.only(
                                    top: 0, left: 60, right: 60),
                                margin: EdgeInsets.only(top: 15.0),
                                child: RaisedButton(
                                  onPressed: //emailController.text == "" ||
                                      () {
                                    setState(() {
                                      _futureAlbum =
                                          createAlbum(_controller.text);
                                    });
                                  },
                                  elevation: 0.0,
                                  color: Colors.blue,
                                  child: Container(
                                    child: Text(
                                      "Get OTP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ElevatedButton(
                      //   child: Text('Get OTP'),
                      //   onPressed: () {
                      //     setState(() {
                      //       _futureAlbum = createAlbum(_controller.text);
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                )
              : FutureBuilder<Album>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    if (msg) {
                      return Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 40, right: 40),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: Center(
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // child:
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 1,
                                          bottom: 1,
                                          left: 10,
                                          right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.cyan
                                                    .withOpacity(0.1),
                                                blurRadius: 10.0,
                                                offset: Offset(0, 6))
                                          ]),
                                      child: TextFormField(
                                        controller: _controller, //Gmail
                                        readOnly: true,
                                        //maxLines: 20,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            //hintText: "Email or Phone number",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // child:
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 2, left: 10, right: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.cyan
                                                    .withOpacity(0.1),
                                                blurRadius: 10.0,
                                                offset: Offset(0, 6))
                                          ]),
                                      child: TextFormField(
                                        controller: _otpcontroller,
                                        //maxLines: null,
                                        keyboardType: TextInputType.number,
                                        // obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "OTP",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // child:
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 2, left: 10, right: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.cyan
                                                    .withOpacity(0.1),
                                                blurRadius: 10.0,
                                                offset: Offset(0, 6))
                                          ]),
                                      child: TextFormField(
                                        controller: _passwordcontroller,
                                        //obscureText: true,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "New Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              // child:
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 47.0,
                                      padding: EdgeInsets.only(
                                          top: 0, left: 60, right: 60),
                                      margin: EdgeInsets.only(top: 15.0),
                                      child: RaisedButton(
                                        onPressed: //emailController.text == "" ||
                                            () {
                                          setState(
                                            () {
                                              confirm(
                                                  _controller.text,
                                                  _passwordcontroller.text,
                                                  _otpcontroller.text);
                                            },
                                          );
                                        },
                                        elevation: 0.0,
                                        color: Colors.blue,
                                        child: Container(
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              // child:
                              child: FadeAnimation(
                                1.6,
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 47.0,
                                      padding: EdgeInsets.only(
                                          top: 0, left: 60, right: 60),
                                      margin: EdgeInsets.only(top: 15.0),
                                    ),
                                    Text(
                                      issucess == true
                                          ? "Successfully Reset"
                                          : "",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Scaffold(
                        backgroundColor: Colors.grey,
                        body: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/images/NoFound.png",
                              fit: BoxFit.cover,
                            ),
                            Container(
                              // bottom: MediaQuery.of(context).size.height * 0.14,
                              // left: MediaQuery.of(context).size.width * 0.065,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 25,
                                      color: Colors.black.withOpacity(0.17),
                                    ),
                                  ],
                                ),
                                child: FlatButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: Text("Back".toUpperCase()),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    return SpinKitChasingDots(color: Color(0XFFA2CBFC));
                  },
                ),
        ),
      ),
    );
  }
}
