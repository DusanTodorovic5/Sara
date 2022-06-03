import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:http/http.dart' as http;

class UserSaraAppBar {
  UserSaraAppBar({required this.title, required this.callback}) {
    broj_u_listi = dohvati_listu_zelja();
  }

  String title;
  Function callback;

  Future<int> dohvati_listu_zelja() async {
    var url = Uri.parse("http://localhost:8000/zeli_sa_id");

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'idKorisnik': Manager().user!.id,
      }),
    );

    var r = jsonDecode(response.body) as Map<String, dynamic>;
    var zelje = (r['list']) as List;

    return zelje.length;
  }

  late Future<int> broj_u_listi;

  AppBar dohvati_app_bar(context) => AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "http://localhost/featured/logo.png",
              fit: BoxFit.contain,
              height: 80,
            ),
            Material(
              color: Colors.transparent, // Button color
              child: InkWell(
                splashColor: Colors.grey, // Splash color
                onTap: () {
                  Navigator.pushNamed(context, "/korpa").then((value) {
                    callback();
                  });
                },
                child: Badge(
                  badgeContent: Text(
                    Manager().korpa.length.toString(),
                  ),
                  child: const Icon(Icons.shopping_cart),
                  position: BadgePosition.bottomEnd(),
                  badgeColor: const Color.fromARGB(255, 249, 206, 223),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Material(
              color: Colors.transparent, // Button color
              child: InkWell(
                splashColor: Colors.grey, // Splash color
                onTap: () {
                  Navigator.pushNamed(context, "/lista_zelja").then((value) {
                    callback();
                  });
                },
                child: Badge(
                  badgeContent: FutureBuilder<int>(
                    future: broj_u_listi,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.toString());
                      }
                      return const CircularProgressIndicator();
                    },
                  ), // BROJ PROIZVODA IZ LISTE ZELJA
                  child: const Icon(MdiIcons.heart),
                  position: BadgePosition.bottomEnd(),
                  badgeColor: const Color.fromARGB(255, 249, 206, 223),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  Manager().user!.username, //KORISNICKO IME
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Izloguj se",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Manager().izloguj_se(callback);
                    Navigator.pushReplacementNamed(context, "/");
                  },
                ),
              ],
            ),
          ],
        ),
      );
}
