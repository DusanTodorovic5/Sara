import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sara_frontend/classes/product.dart';

class ProizvodUKorpi {
  late Proizvod proizvod;
  late int kolicina;
  late String velicina;

  ProizvodUKorpi({
    required this.proizvod,
    required this.velicina,
    required this.kolicina,
  });

  factory ProizvodUKorpi.fromJson(Map<String, dynamic> _json) {
    return ProizvodUKorpi(
      proizvod: Proizvod.fromJson(_json['proizvod']),
      velicina: _json['velicina'],
      kolicina: _json['kolicina'],
    );
  }
  Map<String, dynamic> toJson() => {
        'proizvod': proizvod.toJson(),
        'velicina': velicina,
        'kolicina': kolicina,
      };
}
