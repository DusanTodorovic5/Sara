//AUTHOR: Ivana Trtovic
import 'package:flutter/material.dart';
import 'package:sara/pages/cash_out_page.dart';
import 'package:sara/pages/try_out_page.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<String> images = [
    "assets/draggable/c1.png",
    "assets/draggable/d1.png",
    "assets/draggable/c2.png",
    "assets/draggable/d2.png",
  ];
  final List<String> odeca = <String>[
    "majica prototip",
    "suknja prototip",
    "bluza prototip",
    "pantalone prototip"
  ];
  final List<int> colorCodes = <int>[600, 500, 100];
  List<int> _itemCount = [1,3,2,5]; //proveriti
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
                  const Text(
                    "Količina: ",
                    textAlign: TextAlign.left, //ovde je bilo left

                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Text(
                    _itemCount[0].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => setState(() => {_itemCount[0]++}),
                        child: const Icon(
                            IconData(0xe799, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => {if (_itemCount[0] > 1) _itemCount[0]--}),
                        child: const Icon(
                            IconData(0xe798, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      //Icon(IconData(0xe799, fontFamily: 'MaterialIcons')),
                      //Icon(IconData(0xe798, fontFamily: 'MaterialIcons')),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                          IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
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
                  const Text(
                    "Količina: ",
                    textAlign: TextAlign.left, //ovde je bilo left

                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Text(
                    _itemCount[1].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => setState(() => _itemCount[1]++),
                        child: const Icon(
                            IconData(0xe799, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => {if (_itemCount[1] > 1) _itemCount[1]--}),
                        child: const Icon(
                            IconData(0xe798, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      //Icon(IconData(0xe799, fontFamily: 'MaterialIcons')),
                      //Icon(IconData(0xe798, fontFamily: 'MaterialIcons')),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                          IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
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
                  const Text(
                    "Količina: ",
                    textAlign: TextAlign.left, //ovde je bilo left

                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Text(
                    _itemCount[2].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => setState(() => _itemCount[2]++),
                        child: const Icon(
                            IconData(0xe799, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => {if (_itemCount[2] > 1) _itemCount[2]--}),
                        child: const Icon(
                            IconData(0xe798, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      //Icon(IconData(0xe799, fontFamily: 'MaterialIcons')),
                      //Icon(IconData(0xe798, fontFamily: 'MaterialIcons')),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(
                          IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
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
                child: Image.asset(images[3], fit: BoxFit.fitHeight),
              ),
              trailing: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  const Text(
                    "Količina: ",
                    textAlign: TextAlign.left, //ovde je bilo left

                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Text(
                    _itemCount[3].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color.fromARGB(255, 140, 187, 241)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () => setState(() => _itemCount[3]++),
                        child: const Icon(
                            IconData(0xe799, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => setState(() => {if (_itemCount[3] > 1) _itemCount[3]--}),
                        child: const Icon(
                            IconData(0xe798, fontFamily: 'MaterialIcons')),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 140, 187, 241),
                        ),
                      ),
                      //Icon(IconData(0xe799, fontFamily: 'MaterialIcons')),
                      //Icon(IconData(0xe798, fontFamily: 'MaterialIcons')),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(IconData(0xe1bb,
                          fontFamily: 'MaterialIcons')), //kanta
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 249, 206, 223),
                        fixedSize: const Size(200, 200),
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                  //Icon(IconData(0xe1bb, fontFamily: 'MaterialIcons')),
                ],
              ),
            ),
          ),
        ],
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        itemExtent: 75, //100 bilo
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CashOutPage()),
                );
              },
              child: const Text("Kupi"),
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 140, 187, 241),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 300,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TryOutPage()),
                );
              },
              child: const Text("Isprobaj kombinaciju"),
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 140, 187, 241),
            ),
          ),
        ],
      ),
    );
  }
}
