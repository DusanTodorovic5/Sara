//Author: Janko Tufegdzic 0097/19

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Pol { M, Z }

class _RegisterPageState extends State<RegisterPage> {
  Pol? _pol = Pol.M;
  String datum = "";
  DateTime datumD = DateTime(2000, 1, 1, 0, 0);
  bool isDateSelected = false;

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
                'assets/logoWhite.png',
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
                      child: const Text("Registruj se",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )))),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Email adresa"),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 140, 187, 241)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(hintText: "Korisnicko ime"),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 140, 187, 241)),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    child: const TextField(
                      decoration: const InputDecoration(hintText: "Lozinka"),
                      obscureText: true,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 140, 187, 241)),
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(10)),
                    ),
                    child: const TextField(
                      decoration:
                          InputDecoration(hintText: "Potvrdite lozinku"),
                      obscureText: true,
                    ),
                  )),
              Container(
                  //width: 150,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Text(
                      'Izaberite pol:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 70,
                        child: ListTile(
                          title: const Text('Ž'),
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
                          title: const Text('M'),
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
                    width: 170,
                    child: const Text(
                      'Izaberite datum rodjenja:',
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: 20,
                      child: GestureDetector(
                          child: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final datePick = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      primaryColor: const Color(0xFF8CBBF1),
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xFF8CBBF1)),
                                      buttonTheme: const ButtonThemeData(
                                          textTheme: ButtonTextTheme.primary),
                                    ),
                                    child: child!,
                                  );
                                });
                            if (datePick != null && datePick != datumD) {
                              setState(() {
                                datumD = datePick;
                                isDateSelected = true;

                                // put it here
                                datum =
                                    "${datumD.month}/${datumD.day}/${datumD.year}"; // 08/14/2019
                              });
                            }
                          }))
                ],
              )),
              SizedBox(
                  width: 150,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 140, 187, 241))),
                        onPressed: () {},
                        child: const Text(
                          "Registruj se",
                          style: const TextStyle(
                            color: (Colors.white),
                          ),
                        ),
                      ))),
              Container(
                  width: 150,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: SignInButton(
                        Buttons.Google,
                        text: " Registruj se",
                        onPressed: () {},
                      )))
            ],
          ),
        ));
  }
}
