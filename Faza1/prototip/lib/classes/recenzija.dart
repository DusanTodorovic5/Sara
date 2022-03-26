//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';

class Recenzija {
  late String korisnik;
  late String recenzija;
  late DateTime date;

  Recenzija({required String korisnik, required String recenzija}) {
    date = DateTime.now();
    this.korisnik = korisnik;
    this.recenzija = recenzija;
  }
  String dohvDatum() {
    return "" +
        date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString();
  }

  String dohvKorisnika() {
    return korisnik;
  }

  String dohvRecenziju() {
    return recenzija;
  }

  Widget format() {
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
                      korisnik,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Text("   "),
                    Text(
                      dohvDatum(),
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      recenzija,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  ],
                )
              ]),
        ));
  }
}
