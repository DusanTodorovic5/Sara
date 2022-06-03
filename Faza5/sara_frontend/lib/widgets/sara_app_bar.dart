import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/manager.dart';
import 'package:sara_frontend/widgets/app_bars/admin_app_bar.dart';
import 'package:sara_frontend/widgets/app_bars/basic_app_bar.dart';
import 'package:sara_frontend/widgets/app_bars/user_app_bar.dart';

class SaraAppBar {
  SaraAppBar({required this.title, required this.callback});

  String title;
  Function callback;

  AppBar dohvati_app_bar(context) {
    switch (Manager().userType()) {
      case "#":
        return BasicSaraAppBar(
          title: title,
          callback: callback,
        ).dohvati_app_bar(context);
      case "K":
        return UserSaraAppBar(
          title: title,
          callback: callback,
        ).dohvati_app_bar(context);
      case "M":
        return UserSaraAppBar(
          title: title,
          callback: callback,
        ).dohvati_app_bar(context);
      case "A":
        return AdminSaraAppBar(
          title: title,
          callback: callback,
        ).dohvati_app_bar(context);
    }
    return BasicSaraAppBar(
      title: title,
      callback: callback,
    ).dohvati_app_bar(context);
  }
}
