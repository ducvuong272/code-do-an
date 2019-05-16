import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final String postTitle;
  final ScrollController scrollController;
  final List<Comment> commentList;

  const CommentSection({
    Key key,
    this.commentList,
    this.scrollController,
    this.postTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        itemCount: commentList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 1, bottom: 5),
            child: Column(
              children: <Widget>[
                _avatarSection(
                  commentList[index].userAvataImageUrl,
                  commentList[index].firstName,
                  commentList[index].lastName,
                  commentList[index].ratingPoint.toString(),
                  commentList[index].commentTime,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: _commentSection(commentList[index].commentContent),
                ),
              ],
            ),
          );
        });
  }

  Widget _avatarSection(String imageUrl, String firstname, String lastName,
      String ratingPoint, String commentTime) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(
                userAvatarImageUrl: imageUrl,
                lastName: lastName,
                avatarSize: 30,                
              ),
              Text(
                '${lastName.trim()} $firstname',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '$ratingPoint',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '$commentTime',
                style: TextStyle(
                  color: Color(0xff6b6f75),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _commentSection(String commentContent) {
    return Container(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '$postTitle',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                '$commentContent',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
