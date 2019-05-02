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
    double imageWidth = MediaQuery.of(context).size.width * 0.3;
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5),
            height: imageWidth,
            width: imageWidth,
            child: Image.asset(
              'assets/images/1.png',
              fit: BoxFit.fill,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Post title  ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Địa chỉ Địa chỉ Địa chỉ ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4d4e4f),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Điểm đánh giá: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff595a5b),
                      ),
                    ),
                    CircleAvatar(
                      child: Text('6.0'),
                      maxRadius: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
