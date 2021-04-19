import 'package:flutter/material.dart';
import 'webview_container.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebViewContainer(
          'https://webservices.rajmedicity.com/DoctorPrivacyPolicity.html',
          'Privacy Policy'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TermandCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        // color: Colors.amber,
        child: WebViewContainer(
            'https://webservices.rajmedicity.com/DoctorTermandCondition.html',
            'Term and Condition'),
      ),
      theme: ThemeData.light(),

      // theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF) , ),
      debugShowCheckedModeBanner: false,
    );
  }
}
