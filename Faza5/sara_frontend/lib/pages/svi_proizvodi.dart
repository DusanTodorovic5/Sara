import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/widgets/proizvodi_sa_popustom.dart';

import '../classes/manager.dart';
import '../widgets/sara_app_bar.dart';

class SviProizvodi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SviProizvodiState();
}

class _SviProizvodiState extends State<SviProizvodi> {
  late Future<List<Proizvod>> lista;

  Future<List<Proizvod>> svi_proizvodi() async {
    var url = Uri.parse("http://localhost:8000/proizvodi");
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    List<Proizvod> lista = [];
    var proizvodi = jsonDecode(response.body) as List;
    for (var pro in proizvodi) {
      lista.add(Proizvod.fromJson(pro));
    }
    return lista;
  }

  void initState() {
    super.initState();
    lista = svi_proizvodi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SaraAppBar(
            title: "Svi Proizvodi",
            callback: () {
              setState(() {});
            }).dohvati_app_bar(context),
        body: FutureBuilder<List<Proizvod>>(
          future: lista,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!
                    .map((e) => ProizvodSaPopustom(
                        p: e,
                        smanji: (var id, var controller) {
                          smanji(id, controller);
                          setState(() {
                            lista = svi_proizvodi();
                          });
                        }))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else
              return CircularProgressIndicator();
          },
        ));
  }

  Future<bool> smanji(var id, var myController) async {
    var url = Uri.parse("http://localhost:8000/popust");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'popust': myController.text,
          'id': id,
        }));

    return true;
  }
}
