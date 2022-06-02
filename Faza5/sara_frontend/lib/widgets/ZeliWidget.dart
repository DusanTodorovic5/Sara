import 'dart:convert';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/Komentar.dart';
import 'package:http/http.dart' as http;

import '../classes/ProizvodUKorpi.dart';

import '../classes/ProizvodUKorpi.dart';
import '../classes/Zeli.dart';
import '../classes/product.dart';

class ZeliWidget extends StatelessWidget {
  ZeliWidget({
    Key? key,
    required this.zeli,
    required this.promeniStanje,
    required this.obrisi,
  }) : super(key: key) {
    proizvod = dohv_proizvod();
  }

  final Zeli zeli;
  final Function promeniStanje;
  final Function obrisi;
  bool isChecked = false;

  late Future<Proizvod> proizvod;

  Future<Proizvod> dohv_proizvod() async {
    var url = Uri.parse("http://localhost:8000/dohvati_proizvod_sa_id");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, String>{
          'id': zeli.IdProizvoda.toString(),
        },
      ),
    );
    var json = jsonDecode(response.body);
    Proizvod p = Proizvod.fromJson(json['proizvod']);
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: MediaQuery.of(context).size.height * 0.15,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FutureBuilder<Proizvod>(
                        future: proizvod,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.network(
                              "http://localhost/detalji/" +
                                  snapshot.data!.putanja +
                                  "/s1.png",
                              width: 200,
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      Text(
                        zeli.naziv,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 140, 187, 241),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "obavesti:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 140, 187, 241),
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: StarButton(
                          valueChanged: (_) {
                            promeniStanje(zeli.IdProizvoda);
                          },
                          iconColor: Colors.yellow,
                          isStarred: zeli.Obavesti == 'D',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            obrisi(zeli.IdProizvoda);
                          },
                          child: Text(
                            "ukloni",
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
          )),
    );
  }
}
