import 'package:flutter/material.dart';

class FeaturedProduct {
  String niska;

  FeaturedProduct({required this.niska});

  Widget generisi() {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Image.network(niska),
          TextButton(
            onPressed: () {},
            child: Icon(Icons.android),
          )
        ],
      ),
    );
  }
}