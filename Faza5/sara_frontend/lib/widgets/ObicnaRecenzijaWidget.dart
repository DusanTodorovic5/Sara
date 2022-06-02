import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/Komentar.dart';
import 'package:http/http.dart' as http;

class ObicnaRecenzijaWidget extends StatelessWidget {
  const ObicnaRecenzijaWidget({
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
        padding: const EdgeInsets.all(2),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
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
