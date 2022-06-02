//AUTHOR: Janko Tufegdzic
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DodajRecenziju extends StatefulWidget {
  int idProizvoda;

  DodajRecenziju({required this.idProizvoda});

  @override
  State<StatefulWidget> createState() =>
      _DodajRecenzijuState(idProizvoda: idProizvoda);
}

class _DodajRecenzijuState extends State<DodajRecenziju> {
  int idProizvoda;
  final myController = TextEditingController();
  _DodajRecenzijuState({required this.idProizvoda});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Dodajte recenziju"),
      content: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                textAlign: TextAlign.center,
                maxLines: 4,
                controller: myController,
                decoration: InputDecoration(
                    hintText: "Unesite recenziju",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 140, 187, 241),
                    ))),
              ),
              TextButton(
                  onPressed: () {
                    postavi();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Dodaj recenziju",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16),
                    primary: const Color.fromARGB(255, 140, 187, 241),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void postavi() async {
    var url = Uri.parse("http://localhost:8000/recenzija");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'Text': myController.text,
          'IDProizvod': idProizvoda
        }));
  }
}
