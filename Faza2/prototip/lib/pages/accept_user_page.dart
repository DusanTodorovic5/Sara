//AUTHOR: Ana Maksimovic 

import 'package:flutter/material.dart';

class AcceptUsersPage extends StatefulWidget {
  const AcceptUsersPage({Key? key}) : super(key: key);

  @override
  State<AcceptUsersPage> createState() => _AcceptUsersPageState();
}

class _AcceptUsersPageState extends State<AcceptUsersPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 140, 187, 241),
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/logoWhite.png",
                fit: BoxFit.contain,
                height: 100,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          const Text('Novi korisnici',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                 color: Color.fromARGB(255, 140, 187, 241),
                fontWeight: FontWeight.bold,
              )),
          new Expanded(
              child: ListView(children: [
            Container(
              height: 80,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Text(
                      "USERNAME 1",
                      style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 140, 187, 241)),
                    ),
                    Spacer(), // use Spacer
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 140, 187, 241),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        minimumSize: Size(120, 55), //////// HERE
                      ),
                      child: Text('Prihvati',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 140, 187, 241),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        minimumSize: Size(120, 55), //////// HERE
                      ),
                      child: Text('Odbij',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Text(
                      "USERNAME 2",
                      style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 140, 187, 241)),
                    ),
                    Spacer(), // use Spacer
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 140, 187, 241),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        minimumSize: Size(120, 55), //////// HERE
                      ),
                      child: Text('Prihvati',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 140, 187, 241),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        minimumSize: Size(120, 55), //////// HERE
                      ),
                      child: Text('Odbij',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ]))
        ]));
  }
}
