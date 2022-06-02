import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/ProizvodUKorpi.dart';
import 'package:sara_frontend/classes/manager.dart';

import '../widgets/shopping_cart_item.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key) {}

  List<ProizvodUKorpi> f_list = Manager().dohvati_korpu();
  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        toolbarHeight: 100,
        title: const Text("Korpa"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: widget.f_list
              .map(
                (v) => ProizvodUKorpiWidget(pk: v, callback: callback),
              )
              .toList(),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/kupi_proizvod');
              },
              child: const Text("Kupi"),
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 140, 187, 241),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 300,
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(context, '/isprobavanje');
              },
              child: const Text("Isprobaj kombinaciju"),
              shape:
                  const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              backgroundColor: const Color.fromARGB(255, 140, 187, 241),
            ),
          ),
        ],
      ),
    );
  }

  void callback() {
    setState(() {});
  }
}
