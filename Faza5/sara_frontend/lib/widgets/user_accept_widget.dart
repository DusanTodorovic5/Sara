//AUTHOR: Janko Tufegdzic
import 'package:flutter/material.dart';
import 'package:sara_frontend/classes/user_for_accept.dart';

class UserAcceptWidget extends StatelessWidget {
  const UserAcceptWidget({
    Key? key,
    required this.user,
    required this.odbij,
    required this.prihvati,
  }) : super(key: key);

  final UserForAcceptance user;
  final Function prihvati;
  final Function odbij;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          user.username,
          style: TextStyle(
              color: const Color.fromARGB(255, 140, 187, 241),
              fontWeight: FontWeight.bold,
              fontSize: 23),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: ElevatedButton(
                  onPressed: () {
                    prihvati(user.id);
                  },
                  child: const Text("Prihvati"),
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 16),
                    primary: const Color.fromARGB(255, 140, 187, 241),
                  )),
            ),
            ElevatedButton(
                onPressed: () {
                  odbij(user.id);
                },
                child: const Text("Odbij"),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 16),
                  primary: const Color.fromARGB(255, 140, 187, 241),
                )),
          ],
        )
      ]),
    );
  }
}
