// Author : Ana Maksimovic

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sara/classes/singleton.dart';
import 'package:sara/pages/login_page.dart';
import 'package:sara/pages/mod_product_page.dart';
import 'package:sara/pages/product_page.dart';
import 'package:sara/pages/register_page.dart';
import 'package:sara/widgets/user_bar_part.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 140, 187, 241),
          toolbarHeight: 100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                "https://cdn.discordapp.com/attachments/951897655162834997/955874431211802664/logoWhite.png",
                fit: BoxFit.contain,
                height: 100,
              ),
              (Singleton().mod == "N")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 170,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Pretraga...',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(title: "Ulogujte se")),
                            ).then((value) => setState(() {}));
                          },
                          child: const Text(
                            "Ulogujte se",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage(
                                      title: "Registracija")),
                            );
                          },
                          child: const Text(
                            "Registracija",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  : UserBarPart(context, () {
                      Singleton().mod = "N";
                      setState(() {});
                    }).generisi(),
            ],
          ),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 140, 187, 241),
              ),
              child: GestureDetector(
                child: const Text("Vrati se na početni ekran"),
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
            const Text(
              "Ženska odeća",
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 134, 134, 134)),
            ),
            ListTile(
              title: const Text('Haljine'),
              leading: const Icon(MdiIcons.faceWoman),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "U prototipu je implementiran samo prikaz košulja",
                    textAlign: TextAlign.center,
                  ),
                ));
              },
            ),
            ListTile(
              title: const Text('Pantalone'),
              leading: const Icon(MdiIcons.nullIcon),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "U prototipu je implementiran samo prikaz košulja",
                    textAlign: TextAlign.center,
                  ),
                ));
              },
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Text(
              "Muška odeća",
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 134, 134, 134)),
            ),
            ListTile(
              title: const Text('Majice'),
              leading: const Icon(MdiIcons.tshirtCrew),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "U prototipu je implementiran samo prikaz košulja",
                    textAlign: TextAlign.center,
                  ),
                ));
              },
            ),
            ListTile(
              title: const Text('Košulje'),
              leading: const Icon(MdiIcons.tshirtV),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListPage()),
                );
              },
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const Text(
              "Dečija odeća",
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 134, 134, 134)),
            ),
            ListTile(
              title: const Text('Majice'),
              leading: const Icon(MdiIcons.tshirtCrew),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "U prototipu je implementiran samo prikaz košulja",
                    textAlign: TextAlign.center,
                  ),
                ));
              },
            ),
            ListTile(
              title: const Text('Pantalone'),
              leading: const Icon(MdiIcons.nullIcon),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "U prototipu je implementiran samo prikaz košulja",
                    textAlign: TextAlign.center,
                  ),
                ));
              },
            ),
          ],
        )),
        body: Column(
          children: [
            const Text('Kosulje',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                )),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod != "M") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja1.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja2.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja3.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja4.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja5.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja6.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 6',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (Singleton().mod == "U") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(title: "Sara")),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModProductPage()),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/kosulja7.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Text(
                        'Kosulja 7',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            backgroundColor:
                                Color.fromARGB(255, 140, 187, 241)),
                      )
                    ],
                  ),
                ),
              ],
            ))
          ],
        ));
  }
}
