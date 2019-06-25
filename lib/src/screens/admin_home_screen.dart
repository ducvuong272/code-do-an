import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

import 'manage_post_category_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  final User user;

  const AdminHomeScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text('Khu vực quản trị viên'),
          centerTitle: true,
          elevation: 0.0,
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  UserAvatar(
                    avatarSize: 40,
                    userAvatarImageUrl: user.imageUrl,
                    lastName: user.lastName,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '${user.lastName} ${user.firstName}',
                          style: TextStyle(fontSize: 30),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                        ),
                      ),
                      Text(
                        'Quản trị viên',
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ManagePostCategoryScreen()),
                      );
                    },
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý loại hình địa điểm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý địa điểm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý loại sản phẩm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý tỉnh thành phố',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý tài khoản',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý bình luận',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    color: Colors.red,
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          'Quản lý vai trò',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
