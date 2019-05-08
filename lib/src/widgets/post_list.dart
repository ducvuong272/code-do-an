import 'package:do_an_tn/src/models/post.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final Post post;

  const PostList({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * 0.3;
    print(post.postId);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
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
                child: Image.network(
                  post.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post.postTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      post.address,
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
                          child: Text('${post.ratingPoint}'),
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
