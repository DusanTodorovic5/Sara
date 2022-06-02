import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../classes/manager.dart';

class BuyProductsPage extends StatefulWidget {
  const BuyProductsPage({Key? key}) : super(key: key);

  @override
  State<BuyProductsPage> createState() => _BuyProductsPage();
}

class _BuyProductsPage extends State<BuyProductsPage> {
  var txtIme = new TextEditingController();
  var txtUlica = new TextEditingController(); //
  var txtBroj = new TextEditingController(); //
  var txtSprat = new TextEditingController(); //
  var txtBrojStana = new TextEditingController(); //
  var txtPostanskiBroj = new TextEditingController();
  var txtMesto = new TextEditingController();
  var txtBrojKartice = new TextEditingController();
  var txtCSV = new TextEditingController();
  var txtDatumIsteka = new TextEditingController();
  var flag = false; // da li treba da dodaje adresu i karticu
  var idA = null;
  var idK = null;

  Future<bool> dohvatiPodatke() async {
    var url = Uri.parse('http://localhost:8000/dohvatiPodatke');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{
        'id': Manager().user!.id,
      }),
    );
    print(response.body);
    var json = jsonDecode(response.body);
    txtIme.text = json['ime'];
    var adresa = json['adresa'];
    print(adresa);
    if (adresa != null) postaviAdresu(adresa);
    var kartica = json['kartica'];
    if (kartica != null) postaviKarticu(kartica);
    if (adresa == null && kartica == null) flag = true;
    return true;
  }

  void postaviAdresu(adresa) {
    this.idA = adresa['ID'];
    txtUlica.text = adresa['Ulica'];
    txtBroj.text = adresa['Broj'];
    if (adresa['BrojStana'] != null)
      txtBrojStana.text = adresa['Broj'].toString();
    if (adresa['Sprat'] != null) txtSprat.text = adresa['Sprat'].toString();
    txtPostanskiBroj.text = adresa['PostanskiBroj'].toString();
    txtMesto.text = adresa['Mesto'];
  }

  void postaviKarticu(kartica) {
    this.idK = kartica['ID'];
    txtCSV.text = kartica['CSV'].toString();
    txtBrojKartice.text = kartica['Broj'].toString();
    final tmp = kartica['DatumIsteka'].split(" ");
    print(tmp);
    txtDatumIsteka.text = tmp[0];
  }

  @override
  void initState() {
    dohvatiPodatke();
  }

  var cats = ['Pouzecu', 'Karticom'];
  String cat = 'Pouzecu';
  String nacinPlacanja = "pouzecu";
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        toolbarHeight: 100,
        title: const Text("Isprobavanje"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 187, 192, 197)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtIme,
                          textAlignVertical: TextAlignVertical.center,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtUlica,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtBroj,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtSprat,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtBrojStana,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtPostanskiBroj,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: TextField(
                          controller: txtMesto,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
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
                        height: MediaQuery.of(context).size.height * 0.006,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        //height: MediaQuery.of(context).size.height * 0.035,
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
                        width: 200,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Placanje",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 187, 192, 197)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 140, 187, 241),
                          border: Border.all(
                              color: Color.fromARGB(255, 140, 187, 241)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButton(
                            style: TextStyle(color: Colors.white),
                            value: cat,
                            icon: Row(children: [
                              Text(
                                "  Izaberite nacin placanja",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ]),
                            dropdownColor: Color.fromARGB(255, 140, 187, 241),
                            items: cats.map((String cats) {
                              return DropdownMenuItem(
                                  child: Text(cats), value: cats);
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                cat = newVal!;
                              });
                              if (cat == "Karticom")
                                _isEnable = true;
                              else
                                _isEnable = false;
                            }),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Visibility(
                        visible: _isEnable,
                        child: TextField(
                          controller: txtBrojKartice,
                          enabled: _isEnable,
                          decoration: InputDecoration(
                            hintText: "Broj kartice",
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Visibility(
                            visible: _isEnable,
                            child: TextField(
                              controller: txtCSV,
                              enabled: _isEnable,
                              decoration: InputDecoration(
                                hintText: "CSV",
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.006,
                          width: MediaQuery.of(context).size.width * 0.006,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.134,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Visibility(
                            visible: _isEnable,
                            child: TextField(
                              controller: txtDatumIsteka,
                              enabled: _isEnable,
                              decoration: InputDecoration(
                                hintText: "Datum isteka",
                                labelStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.045,
                  child: RaisedButton(
                    child: Text("Kupi", style: TextStyle(fontSize: 30)),
                    textColor: Colors.white,
                    color: const Color.fromARGB(255, 140, 187, 241),
                    onPressed: () {
                      if (cat == "Karticom") {
                        nacinPlacanja = "kartica";
                      } else
                        nacinPlacanja = "pouzecu";
                      otpremi();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> otpremi() async {
    var url = Uri.parse("http://localhost:8000/kupi");
    print(Manager().korpa.map(
      (e) {
        return {
          "ID": e.proizvod.id,
          "velicina": e.velicina,
          "kolicina": e.kolicina,
        };
      },
    ).toList());
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          "idKor": Manager().user!.id,
          "proizvodi": Manager().korpa.map(
            (e) {
              return {
                "ID": e.proizvod.id,
                "velicina": e.velicina,
                "kolicina": e.kolicina,
              };
            },
          ).toList(),
          'cena': Manager().getCena(),
          "adresa": {
            "Ulica": txtUlica.text,
            "Broj": txtBroj.text,
            "Sprat": txtSprat.text,
            "BrojStana": txtBrojStana.text,
            "PostanskiBroj": txtPostanskiBroj.text,
            "Mesto": txtMesto.text,
          },
          "flag": flag,
          "placanje": nacinPlacanja,
          "kartica": {
            "BrojKartice": txtBrojKartice.text,
            "CSV": txtCSV.text,
            "DatumIsteka": txtDatumIsteka.text,
          },
          "idA": this.idA,
          "idK": this.idK,
        }));
    print(response.body);
    return true;
  }
}
