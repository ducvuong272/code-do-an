import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final String postTitle, address, imageUrl;

  const PostList({
    Key key,
    this.postTitle,
    this.address,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * 0.3;
    return Container(
      margin: EdgeInsets.only(top: 5),
      color: Colors.white,
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: () {},
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                height: imageWidth,
                width: imageWidth,
                child: imageUrl == null
                    ? Image.asset(
                        'assets/images/1.png',
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      postTitle == null ? 'Post title  ' : postTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      address == null ? 'Địa chỉ Địa chỉ Địa chỉ ' : address,
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
        ),
      ),
    );
  }
}
