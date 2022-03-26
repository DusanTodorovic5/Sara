// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';


class TryOutPage extends StatefulWidget {
  TryOutPage({Key? key}) : super(key: key);

  @override
  State<TryOutPage> createState() => _TryOutPageState();
}

class _TryOutPageState extends State<TryOutPage> {
  String myImage = "assets/draggable/transparent.png";
  String myImage2 = "assets/draggable/transparent.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/logoWhite.png",
              fit: BoxFit.contain,
              height: 100,
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
            children: [
              Draggable<String>(
                data: "assets/draggable/c1.png",
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Image.asset("assets/draggable/c1.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Image.asset("assets/draggable/c1.png",
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
                    child: Image.asset("assets/draggable/c1.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Draggable<String>(
                data: "assets/draggable/d1.png",
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Image.asset("assets/draggable/d1.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Image.asset("assets/draggable/d1.png",
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
                    child: Image.asset("assets/draggable/d1.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Draggable<String>(
                data: "assets/draggable/c2.png",
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Image.asset("assets/draggable/c2.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Image.asset("assets/draggable/c2.png",
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
                    child: Image.asset("assets/draggable/c2.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Draggable<String>(
                data: "assets/draggable/d2.png",
                child: Container(
                  height: 100.0,
                  width: 100.0,
                  color: Colors.lightGreenAccent,
                  child: Center(
                    child: Image.asset("assets/draggable/d2.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
                feedback: Container(
                  color: Colors.deepOrange,
                  height: 100,
                  width: 100,
                  child: Center(
                    child: Image.asset("assets/draggable/d2.png",
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
                    child: Image.asset("assets/draggable/d2.png",
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Image.asset(
                "assets/draggable/model.png",
                width: 335 *
                    (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) /
                    1010,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 385 *
                    ((MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) /
                        1010),
                right: 66 *
                    (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top) /
                    1010,
                child: DragTarget<String>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Image.asset(
                        myImage2,
                        width: 205 *
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) /
                          1010,
                      );
                    },
                    onAccept: (String data) {
                      setState(() {
                        if (data.split("/")[2].contains("d")) {
                          myImage2 = data;
                        }
                      });
                    },
                  ),
              ),
              Positioned(
                top: 185 *
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
                    return Image.asset(
                      myImage,
                      width: 216 *
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top) /
                          1010,
                    );
                  },
                  onAccept: (String data) {
                    setState(() {
                      if (data.split("/")[2].contains("c")) {
                        myImage = data;
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
