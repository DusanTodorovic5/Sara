import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/widgets/proizvodi_sa_popustom.dart';

import '../classes/manager.dart';
import '../widgets/sara_app_bar.dart';

class Proizvodi extends StatefulWidget {
  Proizvodi({Key? key, this.kategorija}) : super(key: key);

  String? kategorija;

  @override
  State<StatefulWidget> createState() => _ProizvodiState();
}

class _ProizvodiState extends State<Proizvodi> {
  late Future<List<Proizvod>> lista;

  Future<List<Proizvod>> svi_proizvodi() async {
    var url = Uri.parse("http://localhost:8000/filter");
    var niz = [];

    if (musko && zensko) {
      niz = ["Z", "M"];
    } else if (musko) {
      niz = ["M"];
    } else if (zensko) {
      niz = ["Z"];
    }

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, dynamic>{
          'Pol': niz,
          "Tekst": txt,
          "Cena": [_currentRangeValues.start, _currentRangeValues.end],
          "Kategorija": widget.kategorija != null ? [widget.kategorija] : [],
        },
      ),
    );

    List<Proizvod> lista = [];
    var proizvodi = jsonDecode(response.body) as List;
    for (var pro in proizvodi) {
      lista.add(Proizvod.fromJson(pro));
    }
    return lista;
  }

  void initState() {
    super.initState();
    lista = svi_proizvodi();
  }

  String txt = "";
  RangeValues _currentRangeValues = RangeValues(0, 50000);
  bool musko = false;
  bool zensko = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Proizvodi",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Opseg cene:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: RangeSlider(
                  values: _currentRangeValues,
                  max: 50000,
                  divisions: 200,
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 160,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Pretraga...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    txt = value;
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Z"),
                      Checkbox(
                        checkColor: Colors.white,
                        value: zensko,
                        onChanged: (bool? value) {
                          setState(() {
                            zensko = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("M"),
                      Checkbox(
                        checkColor: Colors.white,
                        value: musko,
                        onChanged: (bool? value) {
                          setState(() {
                            musko = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    lista = svi_proizvodi();
                  });
                },
                child: const Text("Pretraga"),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Proizvod>>(
              future: lista,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 3,
                    children: List.generate(snapshot.data!.length, (index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/proizvod?id=" +
                                  snapshot.data![index].id.toString(),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Image.network(
                                  "http://localhost/detalji/" +
                                      snapshot.data![index].putanja +
                                      "/s1.png",
                                  width: 120,
                                ),
                              ),
                              Text(
                                snapshot.data![index].naziv,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> smanji(var id, var myController) async {
    var url = Uri.parse("http://localhost:8000/popust");
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'popust': myController.text,
          'id': id,
        }));

    return true;
  }
}
