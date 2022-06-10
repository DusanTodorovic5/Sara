import 'package:sara_frontend/classes/ProizvodUKorpi.dart';
import 'package:sara_frontend/classes/product.dart';
import 'package:sara_frontend/classes/user.dart';
import 'package:test/test.dart';
import 'package:sara_frontend/classes/manager.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('Logovanje', () {
    test('Manager should be initialized', () async {
      await Hive.initFlutter();
      await Hive.openBox('preference').then((value) {
        Manager().data = value;
        var manager = Manager();

        expect(manager != null, true);
      });
    });
    User u = User(
      id: 4,
      username: "test",
      password: "test123",
      ime: "Testalko",
      datum: "2022-13-21",
      email: "test@alko.com",
      pol: "M",
      potroseno: 50000000,
      tip: "K",
    );
    test('Logovanje korisnika', () async {
      Manager().uloguj_se(u);
      expect(Manager().user != null, true);
    });

    test('Ulogovan korisnik', () async {
      expect(Manager().user != null, true);
    });

    test('Izlogovan korisnik', () async {
      Manager().izloguj_se(null);
      expect(Manager().user == null, true);
    });
  });
}
