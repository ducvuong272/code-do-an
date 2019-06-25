import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String lastName;
  final String userAvatarImageUrl;
  final double avatarSize;

  const UserAvatar({Key key, this.lastName, this.userAvatarImageUrl, this.avatarSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return userAvatarImageUrl == null || userAvatarImageUrl.trim() == ''
        ? Container(
            height: avatarSize,
            width: avatarSize,
            margin: EdgeInsets.only(right: 10),
            child: Center(
              child: Text(
                lastName.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: avatarSize *2/3,
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
              backgroundImage: NetworkImage(userAvatarImageUrl,scale: 1.0),
              maxRadius: avatarSize*2/3,
            ),
          );
  }
}
