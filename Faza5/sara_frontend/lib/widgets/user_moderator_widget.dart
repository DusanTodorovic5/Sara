import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/user.dart';
import 'package:favorite_button/favorite_button.dart';

class UserModeratorWidget extends StatelessWidget {
  final User user;
  final Function promeniStanje;

  UserModeratorWidget({
    Key? key,
    required this.user,
    required this.promeniStanje,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            user.ime,
            style: TextStyle(
                color: const Color.fromARGB(255, 140, 187, 241),
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          StarButton(
            valueChanged: (_) {
              promeniStanje(user.id);
            },
            iconColor: Colors.yellow,
          )
        ],
      ),
    );
  }
}
