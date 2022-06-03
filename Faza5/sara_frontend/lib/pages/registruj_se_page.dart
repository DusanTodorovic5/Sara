import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/widgets/sara_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Pol { M, Z }

class _RegisterPageState extends State<RegisterPage> {
  Pol? _pol = Pol.M;
  String datum = "";
  String username = "";
  String password = "";
  String ponovni_password = "";
  String imeIPrezime = "";
  String email = "";
  DateTime datumD = DateTime(2000, 1, 1, 0, 0);
  bool isDateSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaraAppBar(
          title: "Registracija",
          callback: () {
            setState(() {});
          }).dohvati_app_bar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Container(
                width: 150,
                child: const Text(
                  "Registruj se",
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
                child: TextField(
                  decoration: const InputDecoration(hintText: "Ime i Prezime"),
                  onChanged: (value) {
                    imeIPrezime = value;
                  },
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
                child: TextField(
                  decoration: const InputDecoration(hintText: "Email adresa"),
                  onChanged: (value) {
                    email = value;
                  },
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
                  child: TextField(
                    decoration: InputDecoration(hintText: "Korisnicko ime"),
                    onChanged: (value) {
                      username = value;
                    },
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
                  child: TextField(
                    decoration: const InputDecoration(hintText: "Lozinka"),
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
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
                  child: TextField(
                    decoration:
                        const InputDecoration(hintText: "Potvrdite lozinku"),
                    obscureText: true,
                    onChanged: (value) {
                      ponovni_password = value;
                    },
                  ),
                )),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Izaberite pol:',
                style: TextStyle(fontWeight: FontWeight.bold),
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
            ]),
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
                          setState(
                            () {
                              datumD = datePick;
                              isDateSelected = true;
                              datum =
                                  "${datumD.year}-${datumD.month}-${datumD.day}";
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 150,
                child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 140, 187, 241))),
                      onPressed: () {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email)) {
                          var snackBar = const SnackBar(
                            content:
                                Text("Molim vas ukucajte validnu email adresu"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        if (password != ponovni_password) {
                          var snackBar = const SnackBar(
                            content: Text("Lozinke se ne poklapaju"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        if (!isDateSelected) {
                          var snackBar = const SnackBar(
                            content: Text("Molim vas upisite datum rodjenja!"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        if (username.length < 3 || imeIPrezime.length < 3) {
                          var snackBar = const SnackBar(
                            content: Text("Molim vas upisite ispravne podatke"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        Future<Map> response = registruj();

                        response.then((value) {
                          var snackBar = SnackBar(
                            content: Text(value["reason"]),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushNamed(context, '/');
                        });
                      },
                      child: const Text(
                        "Registruj se",
                        style: TextStyle(
                          color: (Colors.white),
                        ),
                      ),
                    ))),
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: SignInButton(
                  Buttons.Google,
                  text: " Registruj se",
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map> registruj() async {
    var url = Uri.parse("http://127.0.0.1:8000/registruj");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        <String, String>{
          'Username': username,
          "Password": password,
          "Email": email,
          "Pol": _pol == Pol.M ? "M" : "Z",
          "ImeIPrezime": imeIPrezime,
          "Datum": datum,
        },
      ),
    );
    var bod = jsonDecode(response.body);
    return bod;
  }
}
