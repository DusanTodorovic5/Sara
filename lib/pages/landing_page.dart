// AUTHOR : Dušan Todorović

import 'package:flutter/material.dart';
import 'package:prototip/pages/login_page.dart';
import 'package:prototip/pages/register_page.dart';
import 'package:prototip/widgets/featured_product.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

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
            Image.network(
              "https://cdn.discordapp.com/attachments/951897655162834997/955874431211802664/logoWhite.png",
              fit: BoxFit.contain,
              height: 100,
            ),
            Row(
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
                      MaterialPageRoute(builder: (context) => const LoginPage(title: "Ulogujte se")),
                    );
                  },
                  child: const Text(
                    "Ulogujte se",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterPage(title: "Registracija")),
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
          ],
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(Icons.menu),
        ),
      ),
      body: ListView(
        children: [
          ImageSlideshow(
            width: double.infinity,

            height: 800,

            initialPage: 0,

            indicatorColor: const Color.fromARGB(255, 249, 206, 223),

            indicatorBackgroundColor: Colors.grey,

            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://e.snmc.io/i/600/s/8a9e8de02fef41e6894a958aaccfdef5/6389577/ipce-ahmedovski-i-orkestar-tomice-miljica-bila-si-devojcica-godina-mojih-cover-art.jpg',
                  fit: BoxFit.fill,
                ),
              ),
              Image.network(
                'https://i1.sndcdn.com/artworks-000234542603-qysvi2-t500x500.jpg',
                fit: BoxFit.fill,
              ),
              Image.network(
                'https://direct.rhapsody.com/imageserver/images/alb.52994008/600x600.jpg',
                fit: BoxFit.fill,
              ),
            ],

            /// Called whenever the page in the center of the viewport changes.
            onPageChanged: (value) {
              print('Page changed: $value');
            },

            /// Auto scroll interval.
            /// Do not auto scroll with null or 0.
            autoPlayInterval: 3000,

            /// Loops back to first slide.
            isLoop: true,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.network(
                          'https://i.ytimg.com/vi/VlOe4tuVklg/sddefault.jpg'),
                      TextButton(
                        onPressed: () {},
                        child: Icon(Icons.android),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.network(
                          'https://i.ytimg.com/vi/VlOe4tuVklg/sddefault.jpg'),
                      TextButton(
                        onPressed: () {},
                        child: Icon(Icons.android),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: FeaturedProduct(
                        niska:
                            "https://i.ytimg.com/vi/VlOe4tuVklg/sddefault.jpg")
                    .generisi(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
