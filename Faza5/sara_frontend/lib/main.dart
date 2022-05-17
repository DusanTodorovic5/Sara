import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/pages/accept_user_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AcceptUsersPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final myController = new TextEditingController();
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextField(controller: myController),
        TextButton(
            onPressed: () async {
              print(myController.text);
              var url = Uri.parse("http://localhost:8000/pending/" +
                  myController.text +
                  "/true");
              var resp = await http.get(
                url,
                headers: {'Content-Type': 'application/json'},
              );
              print('Response body: ${resp.statusCode}');
            },
            child: Text("Odobri")),
        TextButton(
            onPressed: () async {
              var url = Uri.parse("http://localhost:8000/pending/" +
                  myController.text +
                  "/true");
              var resp = await http.get(
                url,
                headers: {'Content-Type': 'application/json'},
              );
              print('Response body: ${resp.statusCode}');
            },
            child: Text("Odbij")),
      ],
    ));
  }
}
