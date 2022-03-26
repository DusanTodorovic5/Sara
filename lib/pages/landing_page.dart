// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';
import 'package:sara/classes/singleton.dart';
import 'package:sara/pages/list_products.dart';
import 'package:sara/pages/login_page.dart';
import 'package:sara/pages/register_page.dart';
import 'package:sara/widgets/featured_product.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sara/widgets/user_bar_part.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                                builder: (context) =>
                                    const RegisterPage(title: "Registracija")),
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
                    this.setState(() {Singleton().mod = "N";});
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
      body: ListView(
        children: [
          ImageSlideshow(
            width: (MediaQuery.of(context).size.height - 100)/9 > MediaQuery.of(context).size.width/16 ?
            MediaQuery.of(context).size.width:(MediaQuery.of(context).size.height - 100)/9*16,

            height: (MediaQuery.of(context).size.height - 100)/9 > MediaQuery.of(context).size.width/16 ?
            MediaQuery.of(context).size.width/16*9:MediaQuery.of(context).size.height - 100,

            initialPage: 0,

            indicatorColor: const Color.fromARGB(255, 249, 206, 223),

            indicatorBackgroundColor: Colors.grey,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/featured/first.png',
                  fit: BoxFit.fill,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/featured/second.png',
                  fit: BoxFit.fill,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/featured/third.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {
              print('Page changed: $value');
            },

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 4000,

            /// Loops back to first slide.
            isLoop: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: FeaturedProduct(
                          niska:
                              "assets/highlighted/highlight1.png",opis:"Nove ženske košulje")
                      .generisi(),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: FeaturedProduct(
                          niska:
                              "assets/highlighted/highlight2.png",opis:"Nove muške košulje")
                      .generisi(),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: FeaturedProduct(
                          niska:
                              "assets/highlighted/highlight3.png",opis:"Nove ženske farmerice")
                      .generisi(),
                ),
                flex: 1,
              ),
            ],
          ),
          Container(
            height: 200,
            alignment: Alignment.topLeft,
            color: const Color.fromARGB(255, 140, 187, 241),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Briga o potrošačima",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Ekskluzivna usluga",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Kontaktirajte nas",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Pomoć",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Narudžbine",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Povraćaj novca",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "O nama",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Profil kompanije",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Podaci kompanije",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Odnos sa investitorima",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Karijere",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Prava",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Pravne napomene",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Uslovi",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Politika privatnosti",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Politika kolačića",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "Omogućili",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Dušan Todorović",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Ana Maksimović",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Ivana Trtović",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Janko Tufegdžić",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
