import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 30,
      margin: EdgeInsets.only(right: 10),
      child: Center(
        child: Text(
          'V',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(50),
        shape: BoxShape.circle,
        color: Colors.purple,
      ),
    );
  }
}
