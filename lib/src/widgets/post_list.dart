import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final String postTitle, address;

  const PostList({
    Key key,
    this.postTitle,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 100,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Image.asset('assets/images/1.png'),
          Column(
            children: <Widget>[
              Text('Post title'),
              Text('Địa chỉ')
            ],
          ),
        ],
      ),
    );
  }
}
