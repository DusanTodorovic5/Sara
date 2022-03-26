// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';

class FeaturedProduct {
  String niska;
  String opis;
  FeaturedProduct({required this.niska, required this.opis});

  Widget generisi() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.asset(niska),
          TextButton(
            onPressed: () {},
            child: Text(
              opis,
              style: const TextStyle(
                color: Color.fromARGB(255, 140, 187, 241),
              ),
            ),
          )
        ],
      ),
    );
  }
}
