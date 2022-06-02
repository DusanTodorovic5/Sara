import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/widgets/sara_app_bar.dart';

import '../classes/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  String password = "";
  String username = "";
  void _incrementCounter() {
    Navigator.pushNamed(context, '/second');
  }

  Future<Map> login_provera() async {
    var url = Uri.parse("http://localhost:8000/login_submit");
    //  print(username + "-" + password);
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'Username': username,
        "Password": password,
      }),
    );
    var bod = jsonDecode(response.body);
    print(bod);

    return bod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color.fromARGB(255, 140, 187, 241),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              "http://localhost/featured/logo.png",
              fit: BoxFit.contain,
              height: 80,
            ),
            TextButton(
              child: const Text(
                "Registruj se",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/registracija');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                width: 150,
                child: const Text(
                  "Uloguj se",
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
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextFormField(
                    decoration:
                        const InputDecoration(hintText: "Korisnicko ime"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      setState(() {
                        username = text;
                      });
                    },
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Color.fromARGB(255, 140, 187, 241)),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Lozinka"),
                    obscureText: true,
                    onChanged: (text) {
                      setState(() {
                        password = text;
                      });
                    },
                  ),
                )),
            SizedBox(
              width: 150,
              child: Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 140, 187, 241))),
                  onPressed: () {
                    login_provera().then((value) {
                      if (!value['success']) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Netacna sifra ili korisnicko ime",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } else {
                        Manager()
                            .uloguj_se(User.fromJson(value['korisnik']))
                            .then((value) {
                          Navigator.pop(context);
                        });
                      }
                    });
                  },
                  child: const Text(
                    "Uloguj se",
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
    );
  }
}
