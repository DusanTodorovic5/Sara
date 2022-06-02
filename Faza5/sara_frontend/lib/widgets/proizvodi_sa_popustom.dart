import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/widgets/dodaj_kolicinu_widget.dart';

class ProizvodSaPopustom extends StatelessWidget {
  Proizvod p;
  late Text cena;
  late Function smanji;
  var myController;
  ProizvodSaPopustom({required this.p, required this.smanji}) {
    cena = Text(
      p.cena.toStringAsFixed(2),
      style: TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 140, 187, 241),
        fontWeight: FontWeight.bold,
      ),
    );
    myController = TextEditingController(text: p.popust.toString());
  }

  void prikazi(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DodajKolicinu(idProizvoda: p.id);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: MediaQuery.of(context).size.height * 0.15,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Image.network(
                  "http://localhost/detalji/" + p.putanja + "/s1.png",
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(p.naziv),
              ],
            ),
            Row(
              children: [
                Text(
                  "Cena:",
                  style: TextStyle(
                    color: Color.fromARGB(255, 140, 187, 241),
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                cena,
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.05,
                  child: TextField(
                    controller: myController,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Future<bool> done = smanji(p.id, myController);
                    },
                    child: Text(
                      "Primeni",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16),
                      primary: const Color.fromARGB(255, 140, 187, 241),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      prikazi(context);
                    },
                    child: Text(
                      "Dodaj velicinu",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 16),
                      primary: const Color.fromARGB(255, 140, 187, 241),
                    ),
                  ),
                )
              ],
            )
          ]),
        ));
  }
}
