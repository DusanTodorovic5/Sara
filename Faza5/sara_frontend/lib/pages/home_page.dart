import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:sara_frontend/widgets/menu.dart';
import 'package:http/http.dart' as http;
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
  Future<List<Proizvod>> preporuka() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        Manager().gps = false;
      } else if (permission == LocationPermission.deniedForever) {
        print("'Location permissions are permanently denied");
        Manager().gps = false;
      } else {
        print("GPS Location service is granted");
        Manager().gps = true;
      }
    } else {
      Manager().gps = true;
      print("GPS Location permission granted.");
    }

    String long = "80.245";
    String lat = "29.65";
    if (Manager().gps) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
    }
    String username = "##";
    String password = "#";
    if (Manager().userType() != "#") {
      username = Manager().user!.username;
      password = Manager().user!.password;
    }

    var url = Uri.parse("http://localhost:8000/preporuka");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, String>{
          "lat": lat,
          "long": long,
          "Username": username,
          "Password": password,
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

  late Future<List<Proizvod>> prozvodi;

  void initState() {
    super.initState();
    prozvodi = preporuka();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Registracija",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      drawer: MyMenu().getDrawer(context, true, () {
        setState(() {});
      }),
      body: ListView(
        children: [
          ImageSlideshow(
            width: (MediaQuery.of(context).size.height - 100) / 9 >
                    MediaQuery.of(context).size.width / 16
                ? MediaQuery.of(context).size.width
                : (MediaQuery.of(context).size.height - 100) / 9 * 16,

            height: (MediaQuery.of(context).size.height - 100) / 9 >
                    MediaQuery.of(context).size.width / 16
                ? MediaQuery.of(context).size.width / 16 * 9
                : MediaQuery.of(context).size.height - 100,

            initialPage: 0,

            indicatorColor: const Color.fromARGB(255, 249, 206, 223),

            indicatorBackgroundColor: Colors.grey,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'http://localhost/featured/first.png',
                  fit: BoxFit.fill,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'http://localhost/featured/second.png',
                  fit: BoxFit.fill,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'http://localhost/featured/third.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {},

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 4000,

            /// Loops back to first slide.
            isLoop: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: FutureBuilder<List<Proizvod>>(
              future: prozvodi,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    physics:
                        const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    shrinkWrap: true, // You won't see infinite size error
                    crossAxisCount: 3,
                    children: snapshot.data!.map((e) {
                      return SizedBox(
                        height: 400,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: GestureDetector(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    "http://localhost/detalji/" +
                                        e.putanja +
                                        "/s1.png",
                                    height: 300,
                                  ),
                                  Text(e.naziv),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  "/proizvod?id=" + e.id.toString(),
                                ).then((value) {
                                  setState(() {});
                                });
                              }),
                        ),
                      );
                    }).toList(),
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
}
