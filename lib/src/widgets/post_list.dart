import 'package:do_an_tn/src/models/enum.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final Post post;
  final User user;
  final Function deletePostfunction;
  final Function updatePostFunction;
  final TypeOfPostList typeOfPostList;

  const PostList({
    Key key,
    this.post,
    this.user,
    this.deletePostfunction,
    this.typeOfPostList,
    this.updatePostFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * 0.3;
    print(post.postId);
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      color: Colors.white,
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(
                      postId: post.postId,
                      postTitle: post.postTitle,
                      user: user,
                    ),
              ),
            ),
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
                          child:
                              post.ratingPoint == null || post.ratingPoint == ''
                                  ? Text('N/A')
                                  : Text(post.ratingPoint),
                          maxRadius: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              typeOfPostList == TypeOfPostList.userPostList
                  ? GestureDetector(
                      onTap: () => updatePostFunction(),
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            Text('Sửa')
                          ],
                        ),
                      ),
                    )
                  : Container(),
              typeOfPostList != TypeOfPostList.searchPostList
                  ? GestureDetector(
                      onTap: () => deletePostfunction(),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Text('Xóa')
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
