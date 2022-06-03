import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BasicSaraAppBar {
  BasicSaraAppBar({required this.title, required this.callback});

  String title;
  Function callback;

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
            Column(
              children: [
                TextButton(
                  child: const Text(
                    "Uloguj se",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login').then((value) {
                      callback();
                    });
                  },
                ),
                TextButton(
                  child: const Text(
                    "Registruj se",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registracija').then((value) {
                      callback();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      );
}
