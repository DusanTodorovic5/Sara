//AUTHOR: Ivana Trtovic
import 'package:flutter/material.dart';

class WishingList extends StatefulWidget {
  const WishingList({Key? key}) : super(key: key);

  @override
  State<WishingList> createState() => _WishingListState();
}

class _WishingListState extends State<WishingList> {
  List<String> images = [
    "assets/slika1.png",
    "assets/kosulja1.jpg",
    "assets/kosulja2.jpg",
    "assets/kosulja3.jpg",
  ];
  final List<String> odeca = <String>['jakna', 'panatalone', 'patike'];
  final List<int> colorCodes = <int>[600, 500, 100];
  int _itemCount = 0; //proveriti
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: const Text(
                "opis artikla",
                textAlign: TextAlign.left, //ovde je bilo left

                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 140, 187, 241)),
              ),
              leading: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset(images[0], fit: BoxFit.fitHeight),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        IconData(0xe1bb, fontFamily: 'MaterialIcons'),
                      ),
                      // color: Color.fromARGB(255, 140, 187, 241),
                    ),
                  ),
                  //Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                "opis artikla",
                textAlign: TextAlign.left, //ovde je bilo left

                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 140, 187, 241)),
              ),
              leading: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset(images[1], fit: BoxFit.fitHeight),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        IconData(0xe1bb, fontFamily: 'MaterialIcons'),
                      ),
                      // color: Color.fromARGB(255, 140, 187, 241),
                    ),
                  ),
                  //Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                ],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text(
                "opis artikla",
                textAlign: TextAlign.left, //ovde je bilo left
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 140, 187, 241)),
              ),
              leading: ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                  maxWidth: 64,
                  maxHeight: 64,
                ),
                child: Image.asset(images[2], fit: BoxFit.fitHeight),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        IconData(0xe1bb, fontFamily: 'MaterialIcons'),
                      ),
                      // color: Color.fromARGB(255, 140, 187, 241),
                    ),
                  ),
                  //Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                ],
              ),
            ),
          ),
        ],
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemExtent: 75, //100 bilo
      ),
    );
  }
}
