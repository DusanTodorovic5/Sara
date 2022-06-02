//AUTHOR: Janko Tufegdzic
import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/user_for_accept.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/widgets/user_moderator_widget.dart';
import 'dart:convert';

import '../classes/manager.dart';
import '../classes/user.dart';
import '../widgets/sara_app_bar.dart';

class MakeModeratorPage extends StatefulWidget {
  const MakeModeratorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MakeModeratorPageState();
}

class _MakeModeratorPageState extends State<MakeModeratorPage> {
  late Future<List<User>> lista;

  Future<List<User>> dohvatiKorisnike() async {
    var url = Uri.parse("http://localhost:8000/korisnici");

    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    List<User> list = [];
    var users = jsonDecode(response.body) as List;
    for (var user in users) {
      list.add(User.fromJson(user));
    }
    return list;
  }

  void initState() {
    super.initState();
    lista = dohvatiKorisnike();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Registracija",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      body: Column(children: [
        const Text('Korisnici',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45,
              color: Color.fromARGB(255, 140, 187, 241),
              fontWeight: FontWeight.bold,
            )),
        Expanded(
          child: FutureBuilder<List<User>>(
              future: lista,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: snapshot.data!
                        .map((e) => UserModeratorWidget(
                              user: e,
                              promeniStanje: (int i) {
                                Future<bool> odgovor = izvrsi(i);
                              },
                            ))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Greska");
                } else
                  return CircularProgressIndicator();
              }),
        )
      ]),
    );
  }

  Future<bool> izvrsi(int id) async {
    var url = Uri.parse("http://localhost:8000/moderator");
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
}
