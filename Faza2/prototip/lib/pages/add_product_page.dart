//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

enum Pol { M, Z }

class _AddProductPageState extends State<AddProductPage> {
  Pol? _pol = Pol.M;
  String datum = "";
  DateTime datumD = DateTime(2000, 1, 1, 0, 0);
  bool isDateSelected = false;
  final picker = ImagePicker();
  List<XFile?> image = [null, null, null];
  int i = 0;
  var cats = ['Majica', 'Dzemper', 'Kosulja', 'Farmerke'];
  var velicine = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  String cat = 'Majica';
  String vel = 'S';

  Future CameraImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image[i] = img;
      i++;
    });
  }

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
        body: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                      width: 170,
                      child: Text("Dodaj proizvod",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )))),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Naziv proizvoda"),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 140, 187, 241)),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Opis proizvoda",
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Cena"),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 140, 187, 241)),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextField(
                          decoration: InputDecoration(hintText: "Kolicina"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 140, 187, 241),
                            border: Border.all(
                                color: Color.fromARGB(255, 140, 187, 241)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: DropdownButton(
                              style: TextStyle(color: Colors.white),
                              value: vel,
                              icon: Row(children: [
                                Text(
                                  "  Izaberite velicinu",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.arrow_drop_down)
                              ]),
                              dropdownColor: Color.fromARGB(255, 140, 187, 241),
                              items: velicine.map((String velicine) {
                                return DropdownMenuItem(
                                    child: Text(velicine), value: velicine);
                              }).toList(),
                              onChanged: (String? newVal) {
                                setState(() {
                                  vel = newVal!;
                                });
                              }),
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 140, 187, 241),
                      border:
                          Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: DropdownButton(
                        style: TextStyle(color: Colors.white),
                        value: cat,
                        icon: Row(children: [
                          Text(
                            "  Izaberite kategoriju",
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
                        })),
              ),
              Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Unesite tagove"),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 140, 187, 241)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Unesite opseg godina"),
                            ))
                      ]),
                ),
              ),
              Container(
                  width: 250,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Izaberite pol:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                            width: 70,
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
                            width: 70,
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
                            )),
                      ])),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    transformAlignment: Alignment.center,
                    width: 170,
                    child: Text(
                      'Izaberite 3 slike',
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: 20,
                      child: GestureDetector(
                          child: new Icon(Icons.photo_album),
                          onTap: () async {
                            image[i] = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            i++;

                            setState(() {});
                          }))
                ],
              )),
              SizedBox(
                  width: 200,
                  child: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 140, 187, 241))),
                        onPressed: () {},
                        child: Text(
                          "Otpremi",
                          style: TextStyle(
                            color: (Colors.white),
                          ),
                        ),
                      ))),
              Container(
                  height: 100,
                  width: 350,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      image[0] == null
                          ? Center(child: Icon(Icons.add_a_photo_rounded))
                          : Image.asset("../bg.jpg", fit: BoxFit.cover),
                      image[1] == null
                          ? Center(child: Icon(Icons.add_a_photo_rounded))
                          : Image.asset("../bg.jpg", fit: BoxFit.cover),
                      image[2] == null
                          ? Center(child: Icon(Icons.add_a_photo_rounded))
                          : Image.asset("../bg.jpg", fit: BoxFit.cover),
                    ],
                  )))
            ]),
          ),
        ));
  }
}
