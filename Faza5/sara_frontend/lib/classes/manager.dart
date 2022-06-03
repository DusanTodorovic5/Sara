import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:sara_frontend/classes/user.dart';

import 'ProizvodUKorpi.dart';

class Manager {
  static Manager? _instance;

  Manager._internal() {
    if (data.get("user") != null) {
      user = User.fromJson(jsonDecode(data.get("user")));
    } else {
      user = null;
    }
  }

  factory Manager() {
    _instance ??= Manager._internal();
    return _instance!;
  }

  double getCena() {
    if (korpa.length < 1) return 0;
    double i = 0;
    for (var korpica in korpa) {
      i = i + korpica.proizvod.cena * korpica.kolicina;
    }
    return i;
  }

  String userType() {
    if (user == null) {
      return "#";
    }
    return user!.tip;
  }

  Future<void> uloguj_se(User _user) async {
    user = _user;
    await data.put("user", jsonEncode(user!.toJson()));
  }

  void izloguj_se(Function? callback) async {
    user = null;
    korpa = [];
    await data.clear().then((value) {
      if (callback != null) {
        callback();
      }
    });
  }

  Future<void> sacuvaj() async {
    print(korpa);
    await data.put("korpa", jsonEncode(korpa.map((e) => e.toJson()).toList()));
  }

  List<ProizvodUKorpi> dohvati_korpu() {
    String? p = data.get("korpa");
    if (p == null) {
      korpa = [];
      return korpa;
    }
    korpa =
        (jsonDecode(p) as List).map((e) => ProizvodUKorpi.fromJson(e)).toList();
    return korpa;
  }

  void ispisi_sve_iz_korpe() {
    for (ProizvodUKorpi p in korpa) {
      print(p.proizvod.toJson());
      print(p.kolicina);
      print(p.velicina);
      print("##");
    }
  }

  Future<void> dodaj(ProizvodUKorpi p) async {
    print(korpa);
    if (korpa.isEmpty) {
      korpa.add(p);
      await sacuvaj();
      return;
    }
    for (ProizvodUKorpi proizvod in korpa) {
      if (proizvod.proizvod.id == p.proizvod.id &&
          proizvod.velicina == p.velicina) {
        proizvod.kolicina++;
        korpa[korpa.indexWhere((element) =>
            element.proizvod.id == p.proizvod.id &&
            element.velicina == p.velicina)] = proizvod;
        //proizvod.kolicina++;
        await sacuvaj();
        return;
      }
    }
    korpa.add(p);
    await sacuvaj();
  }

  void ukloni(ProizvodUKorpi p) async {
    korpa.remove(p);
    await sacuvaj();
  }

  void umanji_kolicinu(ProizvodUKorpi p) {}

  void isprazni_korpu() {
    for (ProizvodUKorpi proizvod in korpa) {
      korpa.remove(proizvod);
    }
    korpa = [];
    data.clear();
  }

  List<ProizvodUKorpi> korpa = [];

  User? user;
  bool gps = false;
  var data = Hive.box('preference');
}
