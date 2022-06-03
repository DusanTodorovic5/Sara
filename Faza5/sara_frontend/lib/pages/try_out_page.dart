import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/ProizvodUKorpi.dart';
import 'package:sara_frontend/classes/manager.dart';

import '../widgets/shopping_cart_item.dart';

class TryOutPage extends StatefulWidget {
  TryOutPage({Key? key}) : super(key: key);

  List<ProizvodUKorpi> f_list = Manager().dohvati_korpu();

  @override
  State<TryOutPage> createState() => _TryOutPageState();
}

class _TryOutPageState extends State<TryOutPage> {
  String myImage = "transparent";
  String myImage2 = "transparent";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "http://localhost/featured/logo.png",
              fit: BoxFit.contain,
              height: 80,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: widget.f_list.map(
              (v) {
                return Draggable<String>(
                  data: v.proizvod.putanja +
                      "," +
                      (v.proizvod.tagovi.contains("Gornji")
                          ? "1"
                          : v.proizvod.tagovi.contains("Donji")
                              ? "2"
                              : v.proizvod.tagovi.contains("Obuca")
                                  ? "3"
                                  : "4"),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: Colors.lightGreenAccent,
                    child: Center(
                      child: Image.network(
                          "http://localhost/detalji/" +
                              v.proizvod.putanja +
                              "/s1.png",
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  feedback: Container(
                    color: Colors.deepOrange,
                    height: 100,
                    width: 100,
                    child: Center(
                      child: Image.network(
                          "http://localhost/detalji/" +
                              v.proizvod.putanja +
                              "/s1.png",
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  childWhenDragging: Container(
                    foregroundDecoration: const BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    height: 100.0,
                    width: 100.0,
                    color: Colors.pinkAccent,
                    child: Center(
                      child: Image.network(
                          "http://localhost/detalji/" +
                              v.proizvod.putanja +
                              "/s1.png",
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          Stack(
            children: [
              Image.network(
                "http://localhost/featured/model.png",
                width: 335 *
                    (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) /
                    1010,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 350,
                right: -40,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Image.network(
                      "http://localhost/detalji/" + myImage2 + "/s1.png",
                      width: 380,
                    );
                  },
                  onAccept: (String data) {
                    setState(() {
                      if (data.split(",")[1].contains("2")) {
                        myImage2 = data.split(",")[0];
                      }
                    });
                  },
                ),
              ),
              Positioned(
                top: 175 *
                    ((MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) /
                        1010),
                right: 60 *
                    (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) /
                    1010,
                child: DragTarget<String>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Image.network(
                      "http://localhost/detalji/" + myImage + "/s1.png",
                      width: 216 *
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) /
                          1010,
                    );
                  },
                  onAccept: (String data) {
                    setState(() {
                      if (data.split(",")[1].contains("1")) {
                        myImage = data.split(",")[0];
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
