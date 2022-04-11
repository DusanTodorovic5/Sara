//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sara/classes/recenzija.dart';
import 'package:sara/classes/singleton.dart';

class ModProductPage extends StatefulWidget {
  const ModProductPage({Key? key}) : super(key: key);

  @override
  State<ModProductPage> createState() => _ModProductPageState();
}

class _ModProductPageState extends State<ModProductPage> {
  bool vrednost = false;
  var recenzija =
      Recenzija(korisnik: "Pavle", recenzija: "Jako udobna kosulja.");
  var rec1 = Recenzija(korisnik: "Dusan", recenzija: "Prijatan materijal.");
  var rec2 = Recenzija(korisnik: "Stefan", recenzija: "Lepa kosulja.");
  var rec3 =
      Recenzija(korisnik: "Marko", recenzija: "Osecam se prijatno u njoj.");
  String size = "S";

  var sizes = ['S', 'M', 'L', 'XL', 'XXL'];

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
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SingleChildScrollView(
              child: Container(
                  width: constraints.maxWidth / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/slika1.png",
                      ),
                      Image.asset(
                        "assets/slika2.png",
                      ),
                      Image.asset(
                        "assets/slika3.png",
                      ),
                    ],
                  )),
            ),
            Container(
                width: constraints.maxWidth / 2,
                child: Column(children: [
                  Container(
                    height: constraints.maxHeight / 2,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Crna kosulja",
                                style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                    color: Color.fromARGB(255, 140, 187, 241)),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "2300 dinara",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 140, 187, 241)),
                              ),
                            ]),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: SizedBox(
                                      width: 270,
                                      child: DropdownButton(
                                          value: size,
                                          icon: Row(children: [
                                            Text("  Izaberite velicinu"),
                                            Icon(Icons.arrow_drop_down)
                                          ]),
                                          dropdownColor: Color.fromARGB(
                                              255, 140, 187, 241),
                                          items: sizes.map((String sizes) {
                                            return DropdownMenuItem(
                                                child: Text(sizes),
                                                value: sizes);
                                          }).toList(),
                                          onChanged: (String? newVal) {
                                            setState(() {
                                              size = newVal!;
                                            });
                                          }),
                                    )),
                                Text(" "),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  height: 70,
                                  width: 200,
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Dodaj u korpu",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 140, 187, 241)),
                                      ))),
                              LikeButton(size: 70)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recenzije",
                        style: TextStyle(
                            color: Color.fromARGB(255, 140, 187, 241),
                            fontSize: 35,
                            fontStyle: FontStyle.italic),
                      ),
                      Singleton().mod == "A"
                          ? ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "U prototipu se ne mogu dodati popusti",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Dodaj popust"),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 140, 187, 241),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "U prototipu se ne mogu dodati nove recenzije",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                              child: const Text("Dodaj Recenziju"),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color.fromARGB(255, 140, 187, 241),
                              ),
                            ),
                    ],
                  ),
                  Container(
                      height: constraints.maxHeight / 3,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          recenzija.format(),
                          rec1.format(),
                          rec2.format(),
                          rec3.format()
                        ]),
                      ))
                ]))
          ]);
        }));
  }
}
