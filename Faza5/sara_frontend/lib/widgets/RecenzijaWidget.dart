import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/Komentar.dart';
import 'package:http/http.dart' as http;

class RecenzijaWidget extends StatelessWidget {
  const RecenzijaWidget({
    Key? key,
    required this.komentar,
    required this.ime,
    required this.obrisi,
  }) : super(key: key);

  final Komentar komentar;
  final String ime;
  final Function obrisi;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromARGB(255, 140, 187, 241),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text(
                      ime,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text("   "),
                    Text(
                      komentar.Datum.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        obrisi(komentar.ID);
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      komentar.Textt,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                )
              ]),
        ));
  }
}
