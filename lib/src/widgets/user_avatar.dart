import 'package:do_an_tn/src/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final User user;

  const UserAvatar({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 30,
      margin: EdgeInsets.only(right: 10),
      child: Center(
        child: Text(
          user == null ? 'V' : user.name.substring(0, 1).toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.purple,
      ),
    );
  }
}
