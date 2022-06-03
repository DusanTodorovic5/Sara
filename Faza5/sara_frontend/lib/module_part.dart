// app_module.dart
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sara_frontend/pages/product_page.dart';

import 'classes/manager.dart';
import 'pages/accept_user_page.dart';
import 'pages/add_product_page.dart';
import 'pages/all_products_page.dart';
import 'pages/buy_product_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/make_moderator_page.dart';
import 'pages/mod_product_page.dart';
import 'pages/registruj_se_page.dart';
import 'pages/shoping_cart_page.dart';
import 'pages/svi_proizvodi.dart';
import 'pages/try_out_page.dart';
import 'pages/wishlist_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => MyHomePage()),
    ChildRoute(
      '/proizvod',
      child: (_, args) {
        if (args.queryParams['id'] == null) {
          return Proizvodi();
        }
        if (Manager().userType() == "M" || Manager().userType() == "A") {
          return ModProductPage(
            idProizvod: int.parse(args.queryParams['id']!),
          );
        }
        return ProductPage(
          idProizvod: int.parse(args.queryParams['id']!),
        );
      },
    ),
    ChildRoute(
      '/registracija',
      child: (_, __) =>
          Manager().userType() == "#" ? const RegisterPage() : MyHomePage(),
    ),
    ChildRoute(
      '/prihvatanje',
      child: (_, __) =>
          Manager().userType() == "A" ? const AcceptUsersPage() : MyHomePage(),
    ),
    ChildRoute(
      '/moderatori',
      child: (_, __) => Manager().userType() == "A"
          ? const MakeModeratorPage()
          : MyHomePage(),
    ),
    ChildRoute(
      '/dodavanje_proizvoda',
      child: (_, __) =>
          Manager().userType() == "A" ? const AddProductPage() : MyHomePage(),
    ),
    ChildRoute(
      '/svi_proizvodi',
      child: (_, __) =>
          Manager().userType() == "A" ? SviProizvodi() : MyHomePage(),
    ),
    ChildRoute(
      '/login',
      child: (_, __) =>
          Manager().userType() == "#" ? const LoginPage() : MyHomePage(),
    ),
    ChildRoute(
      '/korpa',
      child: (_, __) =>
          Manager().userType() != "#" && Manager().userType() != "A"
              ? ShoppingCart()
              : MyHomePage(),
    ),
    ChildRoute(
      '/kupi_proizvod',
      child: (_, __) =>
          Manager().userType() != "#" && Manager().userType() != "A"
              ? const BuyProductsPage()
              : MyHomePage(),
    ),
    ChildRoute(
      '/proizvodi',
      child: (_, args) => Proizvodi(
        kategorija: args.queryParams['kat'],
      ),
    ),
    ChildRoute(
      '/lista_zelja',
      child: (_, __) => WishlistCart(),
    ),
    ChildRoute(
      '/isprobavanje',
      child: (_, __) => TryOutPage(),
    ),
  ];
}

/*
routes: {
        '/': (context) => MyHomePage(),
        '/proizvod': (context) => //na primer proizvod?id=3
            Manager().userType() == "M" || Manager().userType() == "A"
                ? ModProductPage(idProizvod: 9)
                : ProductPage(idProizvod: 8),
        '/registracija': (context) =>
            Manager().userType() == "#" ? const RegisterPage() : MyHomePage(),
        '/prihvatanje': (context) => Manager().userType() == "A"
            ? const AcceptUsersPage()
            : MyHomePage(),
        '/moderatori': (context) => Manager().userType() == "A"
            ? const MakeModeratorPage()
            : MyHomePage(),
        '/dodavanje_proizvoda': (context) =>
            Manager().userType() == "A" ? const AddProductPage() : MyHomePage(),
        '/svi_proizvodi': (context) =>
            Manager().userType() == "A" ? SviProizvodi() : MyHomePage(),
        '/login': (context) =>
            Manager().userType() == "#" ? const LoginPage() : MyHomePage(),
        '/korpa': (context) =>
            Manager().userType() != "#" && Manager().userType() != "A"
                ? ShoppingCart()
                : MyHomePage(),
        '/kupi_proizvod': (context) =>
            Manager().userType() != "#" && Manager().userType() != "A"
                ? const BuyProductsPage()
                : MyHomePage(),
        '/proizvodi': (context) => Proizvodi(),
        '/lista_zelja': (context) => WishlistCart(),
      },*/
