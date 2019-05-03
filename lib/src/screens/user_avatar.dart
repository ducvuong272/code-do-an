import 'dart:io';

import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          child: GestureDetector(
            onTap: () async {
              ApiHandler api = ApiHandler();
              File file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
                  print(file);
              api.postImage(file);
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
