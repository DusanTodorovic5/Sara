import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/Komentar.dart';
import 'package:http/http.dart' as http;
import 'package:sara_frontend/classes/ProizvodUKorpi.dart';

import '../classes/manager.dart';

class ProizvodUKorpiWidget extends StatefulWidget {
  ProizvodUKorpi pk;
  Function callback;
  ProizvodUKorpiWidget({required this.pk, required this.callback});

  @override
  State<StatefulWidget> createState() => _ProizvodUKorpiWidgetState();
}

class _ProizvodUKorpiWidgetState extends State<ProizvodUKorpiWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "http://localhost/detalji/" +
                    widget.pk.proizvod.putanja +
                    "/s1.png",
                width: 200,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.pk.proizvod.naziv,
                  ),
                  Text(
                    widget.pk.velicina,
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.pk.kolicina.toString(),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.pk.kolicina++;
                      });

                      Manager().sacuvaj();
                    },
                    icon: const Icon(
                      Icons.arrow_upward_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.pk.kolicina > 1) {
                          widget.pk.kolicina--;
                        }
                      });
                      Manager().sacuvaj();
                    },
                    icon: const Icon(
                      Icons.arrow_downward_rounded,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  Manager().ukloni(widget.pk);
                  widget.callback();
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
