//AUTHOR: Janko Tufegdzic
import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/user_for_accept.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sara_frontend/widgets/user_accept_widget.dart';

class AcceptUsersPage extends StatefulWidget {
  const AcceptUsersPage({Key? key}) : super(key: key);

  @override
  State<AcceptUsersPage> createState() => _AcceptUsersPageState();
}

class _AcceptUsersPageState extends State<AcceptUsersPage> {
  late Future<List<UserForAcceptance>> lista;

  Future<List<UserForAcceptance>> dohvatiPending() async {
    var url = Uri.parse("http://localhost:8000/pending");
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    List<UserForAcceptance> list = [];
    var users = jsonDecode(response.body) as List;
    for (var user in users) {
      list.add(UserForAcceptance.fromJson(user));
    }

    return list;
  }

  void initState() {
    super.initState();
    lista = dohvatiPending();
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
              Image.asset(
                "https://docs.flutter.dev/assets/images/shared/brand/flutter/logo/flutter-lockup.png",
                fit: BoxFit.contain,
                height: 100,
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          const Text('Novi korisnici',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                color: Color.fromARGB(255, 140, 187, 241),
                fontWeight: FontWeight.bold,
              )),
          Expanded(
            child: FutureBuilder<List<UserForAcceptance>>(
              future: lista,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: snapshot.data!
                          .map((e) => UserAcceptWidget(
                                user: e,
                                odbij: (int i) {
                                  Future<bool> odgovor = odbij(i);
                                  odgovor.then((value) {
                                    if (value)
                                      print("Ide gas");
                                    else
                                      print("Za basom mile bas");

                                    setState(() {
                                      lista = dohvatiPending();
                                    });
                                  });
                                },
                                prihvati: (int i) {
                                  Future<bool> odgovor = prihvati(i);
                                  odgovor.then((value) {
                                    if (value)
                                      print("Ide gas");
                                    else
                                      print("Za basom mile bas");

                                    setState(() {
                                      lista = dohvatiPending();
                                    });
                                  });
                                },
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text("Greska");
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ]));
  }

  Future<bool> prihvati(int id) async {
    var url = Uri.parse("http://localhost:8000/pending/${id}/true");
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    var bod = jsonDecode(response.body);
    return bod['success'];
  }

  Future<bool> odbij(int id) async {
    var url = Uri.parse("http://localhost:8000/pending/${id}/false");
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    var bod = jsonDecode(response.body);
    return bod['success'];
  }
}
