import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/manager.dart';

class AdminSaraAppBar {
  AdminSaraAppBar({required this.title, required this.callback});
  Function callback;
  String title;

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
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dodavanje_proizvoda');
              },
              child: const Text(
                "Dodaj proizvod",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prihvatanje').then((value) {
                  callback();
                });
              },
              child: const Text(
                "Prihvati korisnike",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/moderatori').then((value) {
                  callback();
                });
              },
              child: const Text(
                "Svi korisnici",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/svi_proizvodi').then((value) {
                  callback();
                });
              },
              child: const Text(
                "Svi proizvodi",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Column(
              children: [
                const Text(
                  "ADMIN",
                  style: TextStyle(
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
