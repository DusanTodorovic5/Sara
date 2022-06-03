import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/pages/buy_product_page.dart';
import 'package:sara_frontend/pages/svi_proizvodi.dart';
import 'module_part.dart';
import 'pages/accept_user_page.dart';
import 'pages/add_product_page.dart';
import 'pages/all_products_page.dart';
import 'pages/home_page.dart';
import 'pages/make_moderator_page.dart';
import 'pages/mod_product_page.dart';
import 'pages/product_page.dart';
import 'pages/registruj_se_page.dart';
import 'pages/login_page.dart';
import 'pages/shoping_cart_page.dart';
import 'pages/wishlist_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  await Hive.initFlutter();
  await Hive.openBox('preference').then((value) {
    Manager().data = value;
    //runApp(const MyApp());
    runApp(ModularApp(module: AppModule(), child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Sara',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
