import 'dart:convert';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html';

import '../classes/manager.dart';
import '../widgets/sara_app_bar.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPage();
}

enum Pol { M, Z }

class _AddProductPage extends State<AddProductPage> {
  void initState() {
    super.initState();
  }

  Pol? _pol = Pol.M;
  var nazivController = TextEditingController();
  var opisController = TextEditingController();
  var cenaController = TextEditingController();
  var sezonaController = TextEditingController();
  var tagoviController = TextEditingController();
  var intervalController = TextEditingController();
  var velicinaController = TextEditingController();
  var kolicinaController = TextEditingController();

  List<String> kodiran = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Registracija",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: const Text(
                    "Dodaj proizvod",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: nazivController,
                    decoration: InputDecoration(hintText: "Naziv proizvoda"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: opisController,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Opis proizvoda",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: cenaController,
                    decoration: InputDecoration(hintText: "Cena"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 140, 187, 241)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        controller: kolicinaController,
                        decoration: InputDecoration(hintText: "Kolicina"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 140, 187, 241)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextField(
                          controller: velicinaController,
                          decoration: InputDecoration(hintText: "Velicina"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    controller: tagoviController,
                    decoration: InputDecoration(hintText: "Tagovi"),
                  ),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: TextField(
                    controller: sezonaController,
                    decoration: InputDecoration(hintText: "Sezona"),
                  ),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 140, 187, 241)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextField(
                              controller: intervalController,
                              decoration: InputDecoration(
                                  hintText: "Unesite opseg godina"),
                            ))
                      ]),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Izaberite pol:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: ListTile(
                        title: Text('Ž'),
                        leading: Radio<Pol>(
                          groupValue: _pol,
                          value: Pol.Z,
                          onChanged: (Pol? p) {
                            setState(() {
                              _pol = p;
                            });
                          },
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: ListTile(
                      title: Text('M'),
                      leading: Radio<Pol>(
                        groupValue: _pol,
                        value: Pol.M,
                        onChanged: (Pol? p) {
                          setState(() {
                            _pol = p;
                          });
                        },
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      transformAlignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.17,
                      child: const Text(
                        'Izaberite 3 slike:',
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.02,
                      child: GestureDetector(
                          child: new Icon(Icons.photo_album),
                          onTap: () async {
                            var picked =
                                await FilePickerWeb.platform.pickFiles();
                            if (picked != null) {
                              kodiran.add(
                                  base64.encode(picked.files.first.bytes!));
                              //print(kodiran);

                            }
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 140, 187, 241))),
                    onPressed: () {
                      print("Salje");
                      otpremi();
                    },
                    child: Text(
                      "Otpremi",
                      style: TextStyle(
                        color: (Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> otpremi() async {
    var url = Uri.parse("http://localhost:8000/proizvod");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'Naziv': nazivController.text,
          'Opis': opisController.text,
          'Cena': cenaController.text,
          'Sezona': sezonaController.text,
          'Tagovi': tagoviController.text,
          'Pol': _pol == Pol.M ? 'M' : 'Z',
          'Velicina': velicinaController.text,
          'Kolicina': kolicinaController.text,
          'Interval': intervalController.text,
          'slika1': kodiran[0],
          'slika2': kodiran[1],
          'slika3': kodiran[2],
        }));
    var bod = jsonDecode(response.body);
    print(response.body);
    return bod['success'];
  }
}
