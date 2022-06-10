import 'package:sara_frontend/classes/ProizvodUKorpi.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:test/test.dart';
import 'package:sara_frontend/classes/manager.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('Korpa', () {
    test('Manager should be initialized', () async {
      await Hive.initFlutter();
      await Hive.openBox('preference').then((value) {
        Manager().data = value;
        var manager = Manager();

        expect(manager != null, true);
      });
    });

    var proizvod = ProizvodUKorpi(
        proizvod: Proizvod(
          cena: 200,
          godinaDo: 15,
          godinaOd: 12,
          id: 3,
          naziv: "Testiranje",
          opis: "neki opis",
          putanja: "nikakava",
          sezona: "Leto",
          tagovi: "nista",
          pol: "M",
          popust: 0,
        ),
        velicina: "XL",
        kolicina: 1);
    test('Manager should add 1 item to shopping cart', () async {
      Manager().dodaj(proizvod).then((value) {
        expect(Manager().korpa.length, 1);
      });
    });

    test('Manager should remove 1 item from shoppping cart', () async {
      Manager().ukloni(proizvod);

      expect(Manager().korpa.length, 0);
    });

    test('Manager should clear shopping cart', () async {
      Manager().isprazni_korpu();

      expect(Manager().korpa.length, 0);
    });

    test('Manager should increment the number of items', () async {
      await Manager().dodaj(proizvod);
      Manager().dodaj(proizvod).then((value) {
        expect(Manager().korpa.length, 1);
      });
    });

    test('Manager should calculate price of shopping cart', () async {
      Manager().dodaj(proizvod).then((value) {
        expect(Manager().getCena(), 600);
      });
    });

    test('Manager should decrement the number of items', () async {
      Manager().umanji_kolicinu(proizvod);

      expect(Manager().korpa.length, 1);
    });
  });
}
