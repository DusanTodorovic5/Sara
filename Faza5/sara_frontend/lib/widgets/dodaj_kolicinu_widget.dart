import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DodajKolicinu extends StatefulWidget {
  int idProizvoda;
  DodajKolicinu({required this.idProizvoda});

  @override
  State<StatefulWidget> createState() =>
      _DodajKolicinuState(idProizvoda: idProizvoda);
}

class _DodajKolicinuState extends State<DodajKolicinu> {
  int idProizvoda;
  _DodajKolicinuState({required this.idProizvoda});
  var velicinaKontroler = TextEditingController();
  var kolicinaKontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Dodaj kolicinu"),
      titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 140, 187, 241),
        fontSize: 25,
      ),
      content: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextField(
                  controller: velicinaKontroler,
                  decoration: InputDecoration(
                    hintText: "Unesite velicinu",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 140, 187, 241),
                    )),
                  ),
                ),
                TextField(
                  controller: kolicinaKontroler,
                  decoration: InputDecoration(
                    hintText: "Unesite kolicinu",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 140, 187, 241),
                    )),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    dodaj();
                    //Navigator.pop(context);
                  },
                  child: Text("Dodaj"),
                )
              ]),
        ),
      ),
    );
  }

  void dodaj() async {
    var url = Uri.parse("http://localhost:8000/dodajVelicinu");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'id': idProizvoda,
          'velicina': velicinaKontroler.text,
          'kolicina': kolicinaKontroler.text
        }));
  }
}
