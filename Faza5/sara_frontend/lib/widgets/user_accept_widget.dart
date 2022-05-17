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
      padding: EdgeInsets.all(5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(user.username),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  prihvati(user.id);
                },
                child: const Text("Prihvati")),
            ElevatedButton(
                onPressed: () {
                  odbij(user.id);
                },
                child: const Text("Odbij")),
          ],
        )
      ]),
    );
  }
}
