import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
void main() {
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(title: 'Sara web shop'),
    );
  }
}