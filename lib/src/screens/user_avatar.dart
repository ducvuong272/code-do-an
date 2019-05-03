import 'package:flutter/material.dart';

class UserAvatarScreen extends StatefulWidget {
  @override
  UserAvatarScreenState createState() => UserAvatarScreenState();
}

class UserAvatarScreenState extends State<UserAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Align(
          alignment: FractionalOffset(0.5, 0.25),
          child: CircleAvatar(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
