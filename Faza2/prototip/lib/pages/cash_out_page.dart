//AUTHOR: Ivana Trtovic 
import 'package:flutter/material.dart';

class CashOutPage extends StatefulWidget {
  const CashOutPage({Key? key}) : super(key: key);

  @override
  State<CashOutPage> createState() => _CashOutPageState();
}

class _CashOutPageState extends State<CashOutPage> {
  late String valueChoose;
  List listItem = ["Plaćanje pouzećem", "Plaćanje karicom"];
  //final items = ["Plaćanje pouzećem", "Plaćanje karicom"];
  List<String> items = ['Plaćanje pouzećem', 'Plaćanje karicom'];
  String? selectedItem = 'Plaćanje pouzećem';

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
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Poruči",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 35, color: Color.fromARGB(255, 140, 187, 241)),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Podaci",
                        textAlign: TextAlign.left, //ovde je bilo left

                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 187, 192, 197)),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Ime i prezime",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Ulica",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Broj zgrade/kuće",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Sprat",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Broj stana",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Poštanski broj",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Mesto",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        height: 35.0,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Broj telefona",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: 500.0,
                        //height: 35.0,
                        child: TextField(
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: "Napomena",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      SizedBox(
                        width: 400,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        items: <String>['Po uzećem', 'Karticom']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        hint: const Text("Odaberi način plaćanja"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 45,
                  child: RaisedButton(
                    child: Text("Plati", style: TextStyle(fontSize: 30)),
                    textColor: Colors.white,
                    color: const Color.fromARGB(255, 140, 187, 241),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
