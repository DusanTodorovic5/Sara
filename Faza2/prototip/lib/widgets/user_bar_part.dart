// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sara/classes/singleton.dart';
import 'package:sara/pages/accept_user_page.dart';
import 'package:sara/pages/add_product_page.dart';
import 'package:sara/pages/all_users_page.dart';
import 'package:sara/pages/shopping_cart_page.dart';
import 'package:sara/pages/wishing_list_page.dart';
import 'package:badges/badges.dart';

class UserBarPart {
  UserBarPart(this.context, this.fun);

  BuildContext context;
  Function fun;
  Widget user() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          width: 170,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pretraga...',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Material(
          color: Colors.transparent, // Button color
          child: InkWell(
            splashColor: Colors.grey, // Splash color
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShoppingCart()),
              );
            },
            child: Badge(
              badgeContent: const Text("4"),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WishingList()),
              );
            },
            child: Badge(
              badgeContent: const Text("3"),
              child: const Icon(MdiIcons.heart),
              position: BadgePosition.bottomEnd(),
              badgeColor: const Color.fromARGB(255, 249, 206, 223),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Text(
            Singleton().mod == "M" ? "Moderator" : "Korisnik",
            style: const TextStyle(color: Colors.white),
          ),
          onTap: () {
            fun();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Image.asset(
            Singleton().mod == "M" ? "assets/moderator.png" : "assets/user.png",
            width: 50,
            height: 50,
          ),
          onTap: () {
            fun();
          },
        ),
        GestureDetector(
          child: const Text(
            "Izloguj se",
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            fun();
          },
        ),
      ],
    );
  }

  Widget admin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          width: 170,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Pretraga...',
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AcceptUsersPage()),
            );
          },
          child: const Text(
            "Odobri korisnike",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllUsers()),
            );
          },
          child: const Text(
            "Svi Korisnici",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddProductPage()),
            );
          },
          child: const Text(
            "Dodaj proizvod",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        GestureDetector(
          child: const Text(
            "Administrator",
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            fun();
          },
        ),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Image.asset(
            "assets/admin.png",
            width: 50,
            height: 50,
          ),
          onTap: () {
            fun();
          },
        ),
        GestureDetector(
          child: const Text(
            "Izloguj se",
            style: TextStyle(fontSize: 12),
          ),
          onTap: () {
            fun();
          },
        ),
      ],
    );
  }

  Widget generisi() {
    return Singleton().mod == "A" ? admin() : user();
  }
}
