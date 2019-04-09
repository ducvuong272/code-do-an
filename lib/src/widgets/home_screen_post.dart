import 'package:flutter/material.dart';

class HomeScreenPost extends StatelessWidget {
  final String postTitle, postDetail;
  final Image postImage;

  const HomeScreenPost({
    Key key,
    this.postTitle,
    this.postDetail,
    this.postImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: postTitle,
      child: Card(
        margin: EdgeInsets.all(5),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Container(
                  height: 150,
                  width: 400,
                  child: postImage,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  postTitle.substring(0, 40) + '...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  postDetail.substring(0, 25) + '...',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
