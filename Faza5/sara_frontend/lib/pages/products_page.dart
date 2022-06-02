/*
 * {
 *  "Pol" : ["Z", "M"],
 *	"Tekst" : null,
 *	"Cena" : [500,2200],
 *	"Kategorija" : ["Prolece", "Jednobojna"]
 * }
 */

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sara_frontend/classes/manager.dart';

import '../widgets/featured_products.dart';
import '../widgets/sara_app_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key) {
    //  String myurl = Uri.base.toString();
    //   parameter = Uri.base.queryParameters["id"] ?? "nema ";
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
        title: "Proizvodi",
        callback: () {
          setState(() {});
        },
      ).dohvati_app_bar(context),
      body: Center(),
    );
  }
}
