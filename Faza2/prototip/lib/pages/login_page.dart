//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sara/classes/singleton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String password = "";
  String username = "";
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
                      border:
                          Border.all(color: const Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(hintText: "Korisnicko ime"),
                      onChanged: (text) {
                        setState(() {
                          username = text;
                        });
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
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
                      if (username == password && username == "admin") {
                        Singleton().mod = "A";
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Ulogovan kao ADMIN",
                            textAlign: TextAlign.center,
                          ),
                        ));
                        Navigator.pop(context);
                      } else if (username == password && username == "mod") {
                        Singleton().mod = "M";
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Ulogovan kao MODERATOR",
                            textAlign: TextAlign.center,
                          ),
                        ));
                        Navigator.pop(context);
                      } else if (username == password && username == "user") {
                        Singleton().mod = "U";
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Ulogovan kao registrovani korisnik",
                            textAlign: TextAlign.center,
                          ),
                        ));
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "Netacna sifra ili korisnicko ime",
                            textAlign: TextAlign.center,
                          ),
                        ));
                      }
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
              Container(
                  width: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: SignInButton(
                        Buttons.Google,
                        text: " Uloguj se",
                        onPressed: () {
                          setState(
                            () {
                              if (username == password && username == "admin") {
                                Singleton().mod = "A";
                              } else if (username == password &&
                                  username == "mod") {
                                Singleton().mod = "M";
                              } else if (username == password &&
                                  username == "user") {
                                Singleton().mod = "U";
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Netacna sifra ili korisnicko ime",
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                              }
                            },
                          );
                        },
                      )))
            ],
          ),
        ));
  }
}
