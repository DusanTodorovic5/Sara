import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/widgets/sara_app_bar.dart';
import '../classes/Zeli.dart';
import '../widgets/ZeliWidget.dart';

class WishlistCart extends StatefulWidget {
  WishlistCart({Key? key}) : super(key: key) {}
  @override
  State<WishlistCart> createState() => _WishlistCartState();
}

class _WishlistCartState extends State<WishlistCart> {
  late Future<List<Zeli>> lista;

  Future<List<Zeli>> dohvati_listu_zelja() async {
    var url = Uri.parse("http://localhost:8000/zeli_sa_id");

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'idKorisnik': Manager().user!.id,
      }),
    );
    List<Zeli> lista = [];

    var r = jsonDecode(response.body) as Map<String, dynamic>;
    var zelje = (r['list']) as List;

    for (var z in zelje) {
      print(z.toString());
      lista.add(Zeli.fromJson(z));
    }

    return lista;
  }

  @override
  void initState() {
    super.initState();
    lista = dohvati_listu_zelja();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Lista zelja",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      body: FutureBuilder<List<Zeli>>(
        future: lista,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data!
                    .map((e) => ZeliWidget(
                          zeli: e,
                          promeniStanje: (int i) {
                            Future<bool> odgovor = izvrsi(i);
                          },
                          obrisi: (int i) {
                            Future<bool> odgovor = obrisi(i);
                            odgovor.then((value) {
                              setState(() {
                                lista = dohvati_listu_zelja();
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
    );
  }
}

Future<bool> izvrsi(int id) async {
  var url = Uri.parse("http://localhost:8000/promeni_obavestavanje");
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(<String, int>{
      'idProizvod': id,
      'idKorisnik': Manager().user!.id,
    }),
  );
  var bod = jsonDecode(response.body);

  return bod['success'];
}

Future<bool> obrisi(int id) async {
  var url = Uri.parse("http://localhost:8000/obrisi_iz_ls");
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(<String, int>{
      'idProizvod': id,
      'idKorisnik': Manager().user!.id, //OVDE DODATI MANAGER.USER.D
    }),
  );
  var bod = jsonDecode(response.body);

  return bod['success'];
}
