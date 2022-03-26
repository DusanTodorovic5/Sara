// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';
import 'pages/landing_page.dart';
void main() {
  runApp(const WebApp());
}

class WebApp extends StatelessWidget {
  const WebApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sara Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(title: 'Sara web shop'),
    );
  }
}
