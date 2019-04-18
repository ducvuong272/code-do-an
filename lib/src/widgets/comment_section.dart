import 'package:do_an_tn/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  final String postTitle;
  final ScrollController scrollController;

  const CommentSection({
    Key key,
    this.postTitle,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      itemCount: 20,
      itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(top: 1, bottom: 5),
            child: Column(
              children: <Widget>[
                _avatarSection(),
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: _commentSection(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _avatarSection() {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              UserAvatar(),
              Text(
                'Vuong Do',
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
                '3.9',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '13/4/2019',
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

  Widget _commentSection() {
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
                'Đồ ăn ngon, quán sạch sẽ, rộng rãi, vị trí đẹp. Nhân viên nhiệt tình ',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
