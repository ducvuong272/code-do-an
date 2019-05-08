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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Ảnh đại diện'),
          elevation: 0.0,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xfffc5a1e),
              Color(0xfff78e67),
              Color(0xffffd5bc),
              // Color(0xfff9b993),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset(0.5, 0.3),
              child: CircleAvatar(
                radius: 150,
                backgroundColor: Colors.blue,
                backgroundImage: widget.user.imageUrl ??
                    NetworkImage(
                        'https://www.codeproject.com/KB/GDI-plus/ImageProcessing2/img.jpg'),
              ),
            ),
            Align(
              alignment: FractionalOffset(0.5, 0.7),
              child: RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Đổi ảnh đại diện',
                  style: TextStyle(fontSize: 18),
                ),
                color: Color(0xff68d6ff),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
