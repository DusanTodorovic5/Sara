//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                      width: 150,
                      child: Text("Uloguj se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )))),
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
                      decoration: InputDecoration(hintText: "Korisnicko ime"),
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
                        onPressed: () {},
                        child: Text(
                          "Uloguj se",
                          style: TextStyle(
                            color: (Colors.white),
                          ),
                        ),
                      ))),
              Container(
                  width: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: SignInButton(
                        Buttons.Google,
                        text: " Uloguj se",
                        onPressed: () {},
                      )))
            ],
          ),
        ));
  }
}
