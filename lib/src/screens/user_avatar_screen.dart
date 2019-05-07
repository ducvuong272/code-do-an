import 'package:do_an_tn/src/models/user.dart';
import 'package:flutter/material.dart';

class UserAvatarScreen extends StatefulWidget {
  final User user;

  const UserAvatarScreen({Key key, this.user}) : super(key: key);

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
          alignment: FractionalOffset(0.5, 0.1),
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.blue,
              backgroundImage: widget.user.imageUrl ??
                  NetworkImage(
                      'https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
