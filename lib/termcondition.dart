import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermCondition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Flutter'),
          ),
          body: const WebView(
            initialUrl: 'https://pub.dev/packages/webview_flutter/install',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
