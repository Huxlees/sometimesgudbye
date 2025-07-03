import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';
import 'forgotpassword.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool isIncorrect = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        // height: 0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xfff7feff), Color(0xfff7feff)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading
            ? Center(child: SpinKitChasingDots(color: Color(0XFFA2CBFC)))
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String test;
    Map data = {'mobileno': email, 'userpassword': pass};
    var jsonResponse = null;
   
    var url = Uri.parse('http://localhost/info/DoctorLogin');
    var response =
        await http.post(url, body: {'mobileno': email, 'userpassword': pass});

    
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        if (this.mounted) {
          setState(
            () {
              _isLoading = false;
            },
          );
        }
        sharedPreferences.setString(
            "token", jsonResponse["doctorid"].toString());
        sharedPreferences.setString(
            "doctor", jsonResponse["doctor"].toString());
        sharedPreferences.setString(
            "doctorid", jsonResponse["doctorid"].toString());
        sharedPreferences.setString(
            "Profile", jsonResponse["Profile"].toString());
        sharedPreferences.setString("profiledescription",
            jsonResponse["profiledescription"].toString());
        sharedPreferences.setString(
            "doctorimageurl", jsonResponse["doctorimageurl"].toString());
        sharedPreferences.setString(
            "availabledays", jsonResponse["availabledays"].toString());
        sharedPreferences.setString(
            "starttime", jsonResponse["starttime"].toString());
        sharedPreferences.setString(
            "endtime", jsonResponse["endtime"].toString());

        test = jsonResponse.toString();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(
        () {
          _isLoading = false;
          print("Incorrect Password");
          isIncorrect = true;
          // final snackBar = SnackBar(content: Text("Password is not correct!"));
          // Scaffold.of(context).showSnackBar(snackBar);
        },
      );
    }
    //_isLoading = false;
  }

  Container buttonSection() {
    return Container(
      child: FadeAnimation(
        1.6,
        Column(
          children: [
            Container(
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(30),
              //     boxShadow: [
              //       BoxShadow(
              //           color: Colors.cyan.withOpacity(0.1),
              //           blurRadius: 10.0,
              //           offset: Offset(0, 6))
              //     ]),
              width: MediaQuery.of(context).size.width,
              height: 47.0,
              padding: EdgeInsets.only(top: 0, left: 60, right: 60),
              margin: EdgeInsets.only(top: 5.0),
              child: RaisedButton(
                onPressed:
                    //  emailController.text == "" ||
                    //         passwordController.text == ""
                    //     ? null
                    //     :
                    () {
                  if (this.mounted) {
                    setState(
                      () {
                        _isLoading = true;
                      },
                    );
                  }
                  signIn(emailController.text, passwordController.text);
                },
                elevation: 0.0,
                color: Colors.blue,
                child: Container(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              // FlatButton(
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   onPressed: _onSignUpButtonPress,
              //   child: Text(
              //     "New",
              //     style: TextStyle(
              //         color: right,
              //         fontSize: 16.0,
              //         fontFamily: "WorkSansSemiBold"),
              //   ),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController errorController = new TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.only(top: 2, bottom: 10, left: 40, right: 40),
      child: Column(
        children: <Widget>[
          Container(
            // child:
            child: FadeAnimation(
              1.6,
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: 1, bottom: 1, left: 10, right: 10),
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
                      controller: emailController,
                      //maxLines: 20,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email or Phone number",
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w300)),
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
                    padding: EdgeInsets.only(top: 2, left: 10, right: 4),
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
                      controller: passwordController,
                      //maxLines: null,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: FadeAnimation(
                1.5,
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.cyan, fontWeight: FontWeight.w400),
                )),
          ),
          // SizedBox(
          //   height: 30,
          // ),
          // FadeAnimation(
          //     1.5,
          //     Text(
          //       "Forgot Password?",
          //       style: TextStyle(color: Colors.cyan),
          //     )),
          Container(
            // child:
            child: FadeAnimation(
              1.6,
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 0, left: 10, right: 4),
                    child: Text(
                      isIncorrect ? "Incorrect Username or Password" : "",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      height: 340,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 140,
            width: 80,
            height: 300,
            child: FadeAnimation(
              1.5,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/FavIcon.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeAnimation(
              1.6,
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 200),
                    child: Center(
                      child: Text(
                        "Welcome Back!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
