import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String lastName;
  final String userAvatarImageUrl;

  const UserAvatar({Key key, this.lastName, this.userAvatarImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userAvatarImageUrl == null || userAvatarImageUrl.trim() == ''
        ? Container(
            height: 50,
            width: 30,
            margin: EdgeInsets.only(right: 10),
            child: Center(
              child: Text(
                lastName.substring(0, 1).toUpperCase(),
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
          )
        : Padding(
            padding: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(userAvatarImageUrl),
              radius: 15,
            ),
          );
  }
}
