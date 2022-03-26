import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
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
          const Text('Svi korisnici',
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
                    const Text(
                      "USERNAME 1",
                      style: const TextStyle(
                          fontSize: 35,
                          color: const Color.fromARGB(255, 140, 187, 241)),
                    ),
                    const Spacer(),
                    const Text(
                      "moderator:",
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 140, 187, 241)),
                    ), // use Spacer
                    const SizedBox(width: 8),
                    StarButton(
                      iconSize: 80,
                      iconColor: Colors.yellow,
                      valueChanged: (_isFavorite) {},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              child: Card(
                child: Row(
                  children: <Widget>[
                    const Text(
                      "USERNAME 2",
                      style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 140, 187, 241)),
                    ),
                    const Spacer(),
                    const Text(
                      "moderator:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 140, 187, 241)),
                    ), // use Spacer
                    const SizedBox(width: 8),
                    StarButton(
                      iconSize: 80,
                      iconColor: Colors.yellow,
                      valueChanged: (_isFavorite) {},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            Container(
              height: 80,
              child: Card(
                child: Row(
                  children: <Widget>[
                    const Text(
                      "USERNAME 3",
                      style: const TextStyle(
                          fontSize: 35,
                          color: const Color.fromARGB(255, 140, 187, 241)),
                    ),
                    const Spacer(),
                    const Text(
                      "moderator:",
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 140, 187, 241)),
                    ), // use Spacer
                    const SizedBox(width: 8),
                    StarButton(
                      iconSize: 80,
                      iconColor: Colors.yellow,
                      valueChanged: (_isFavorite) {},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ]))
        ]));
  }
}
