import 'dart:convert';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/widgets/RecenzijaWidget.dart';
import 'package:sara_frontend/widgets/dodaj_recenziju.dart';
import '../classes/Komentar.dart';
import 'package:http/http.dart' as http;
import '../classes/ProizvodUKorpi.dart';
import '../classes/product.dart';

class ModProductPage extends StatefulWidget {
  ModProductPage({Key? key, required this.idProizvod}) : super(key: key) {}

  int idProizvod;

  @override
  State<ModProductPage> createState() => _ModProductPageState();
}

class _ModProductPageState extends State<ModProductPage> {
  late Future<List<Komentar>> lista;
  late Future<Proizvod> proizvod;
  bool vrednost = false;

  var sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  String size = "S";

  Future<Proizvod> dohv_proizvod() async {
    var url = Uri.parse("http://localhost:8000/dohvati_proizvod_sa_id");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, dynamic>{
          'id': widget.idProizvod,
        },
      ),
    );
    var json = jsonDecode(response.body);
    Proizvod p = Proizvod.fromJson(json['proizvod']);
    return p;
  }

  Future<List<Komentar>> dohvati_sve_recenzije() async {
    var url = Uri.parse("http://localhost:8000/dohvati_sve_recenzije");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, dynamic>{
          'idProizvod': widget.idProizvod,
        },
      ),
    );

    List<Komentar> lista = [];

    var r = jsonDecode(response.body) as Map<String, dynamic>;
    var recenzije = (r['list']) as List;

    for (var recenzija in recenzije) {
      lista.add(Komentar.fromJson(recenzija));
    }

    return lista;
  }

  @override
  void initState() {
    super.initState();
    proizvod = dohv_proizvod();
    //proizvod.then((value) => print(value));
    lista = dohvati_sve_recenzije();
  }

  void prikazi(BuildContext context, int id) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return DodajRecenziju(idProizvoda: id);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "http://localhost/featured/logo.png",
              fit: BoxFit.contain,
              height: 100,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Proizvod>(
          future: proizvod,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                            width: constraints.maxWidth / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://localhost/detalji/" +
                                      snapshot.data!.putanja +
                                      "/s1.png",
                                ),
                                Image.network(
                                  "http://localhost/detalji/" +
                                      snapshot.data!.putanja +
                                      "/s2.png",
                                ),
                                Image.network(
                                  "http://localhost/detalji/" +
                                      snapshot.data!.putanja +
                                      "/s3.png",
                                ),
                              ],
                            )),
                      ),
                      Container(
                        width: constraints.maxWidth / 2,
                        child: Column(
                          children: [
                            Container(
                              height: constraints.maxHeight / 2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data!.naziv,
                                        style: const TextStyle(
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 5,
                                            color: Color.fromARGB(
                                                255, 140, 187, 241)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data!.cena.toString() +
                                            " dinara",
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 140, 187, 241)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            child: SizedBox(
                                              width: 270,
                                              child: DropdownButton(
                                                  value: size,
                                                  icon: Row(children: const [
                                                    Text(
                                                        "  Izaberite velicinu"),
                                                    Icon(Icons.arrow_drop_down)
                                                  ]),
                                                  dropdownColor:
                                                      const Color.fromARGB(
                                                          255, 140, 187, 241),
                                                  items:
                                                      sizes.map((String sizes) {
                                                    return DropdownMenuItem(
                                                        child: Text(sizes),
                                                        value: sizes);
                                                  }).toList(),
                                                  onChanged: (String? newVal) {
                                                    setState(() {
                                                      size = newVal!;
                                                      lista =
                                                          dohvati_sve_recenzije();
                                                    });
                                                  }),
                                            ),
                                          ),
                                          Text(" "),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                            height: 70,
                                            width: 200,
                                            child: TextButton(
                                                onPressed: () {
                                                  dodaj_u_korpu(
                                                      size, snapshot.data!);
                                                },
                                                child: const Text(
                                                  "Dodaj u korpu",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          const Color.fromARGB(
                                                              255,
                                                              140,
                                                              187,
                                                              241)),
                                                ))),
                                        const LikeButton(size: 70)
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
                                ElevatedButton(
                                  onPressed: () {
                                    if (Manager().userType() == "#") {
                                      return;
                                    }
                                    prikazi(context, widget.idProizvod);
                                  },
                                  child: const Text("Dodaj recenziju"),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(
                                        255, 140, 187, 241),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: FutureBuilder<List<Komentar>>(
                                future: lista,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView(
                                        children: snapshot.data!
                                            .map((e) => RecenzijaWidget(
                                                  komentar: e,
                                                  ime: e.username,
                                                  obrisi: (int i) {
                                                    Future<bool> odgovor =
                                                        obrisi(i);
                                                    odgovor.then((value) {
                                                      setState(() {
                                                        lista =
                                                            dohvati_sve_recenzije();
                                                      });
                                                    });
                                                  },
                                                ))
                                            .toList());
                                  } else if (snapshot.hasError) {
                                    return Text(snapshot.error.toString());
                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

Future<bool> obrisi(int id) async {
  var url = Uri.parse("http://localhost:8000/obrisi_recenziju");
  //  print(username + "-" + password);
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(<String, int>{
      'id': id,
    }),
  );
  var bod = jsonDecode(response.body);

  return bod['success'];
}

void dodaj_u_korpu(String size, Proizvod p) async {
  ProizvodUKorpi proizvod_u_korpi =
      ProizvodUKorpi(proizvod: p, velicina: size, kolicina: 1);
  Manager().dodaj(proizvod_u_korpi);
}
