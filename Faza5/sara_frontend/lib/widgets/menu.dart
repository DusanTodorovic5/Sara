import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyMenu {
  Drawer getDrawer(context, flag, callback) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 140, 187, 241),
            ),
            child: GestureDetector(
              child: Image.network(
                "http://localhost/featured/logo.png",
                fit: BoxFit.contain,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/");
              },
            ),
          ),
          ListTile(
            title: const Text('Sve'),
            leading: const Icon(MdiIcons.faceWoman),
            onTap: () {
              Navigator.pushNamed(context, '/proizvodi').then((value) {
                callback();
              });
            },
          ),
          const Text(
            "Kategorije",
            style: TextStyle(
                fontSize: 25, color: Color.fromARGB(255, 134, 134, 134)),
          ),
          ListTile(
            title: const Text('Haljine'),
            leading: const Icon(MdiIcons.faceWoman),
            onTap: () {
              Navigator.pushNamed(context, '/proizvodi?kat=Haljina')
                  .then((value) {
                callback();
              });
            },
          ),
          ListTile(
            title: const Text('Kosulje'),
            leading: const Icon(MdiIcons.tshirtV),
            onTap: () {
              Navigator.pushNamed(context, '/proizvodi?kat=Kosulja')
                  .then((value) {
                callback();
              });
            },
          ),
          ListTile(
            title: const Text('Majice'),
            leading: const Icon(MdiIcons.tshirtCrew),
            onTap: () {
              Navigator.pushNamed(context, '/proizvodi?kat=Majica')
                  .then((value) {
                callback();
              });
            },
          ),
        ],
      ),
    );
  }
}
