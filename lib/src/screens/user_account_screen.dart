import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:do_an_tn/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserAccountScreen extends StatelessWidget {
  final User user;

  const UserAccountScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text('Tài khoản'),
          backgroundColor: Colors.red,
          elevation: 0.0,
        ),
      ),
      body: Container(
        color: Color(0xffc0cde0),
        child: user != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 50.0,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            UserAvatar(
                              user: user,
                            ),
                            Text(
                              '${user.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(
                                      'Xác nhận đăng xuất?',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        highlightColor: Color(0xfff2a98e),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardScreen(),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Text(
                                          'XÁC NHẬN',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      FlatButton(
                                        highlightColor: Color(0xfff2a98e),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'HỦY',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Đăng xuất',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        color: Colors.white,
                        child: FlatButton(
                          splashColor: Color(0xff8df4a0),
                          padding: EdgeInsets.only(left: 10),
                          onPressed: () {
                            print(user.imageUrl);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.image,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Ảnh đại diện & bìa',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 50,
                        color: Colors.white,
                        child: FlatButton(
                          onPressed: () {},
                          splashColor: Color(0xff8df4a0),
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.lock_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Đổi mật khẩu',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Container(
                        height: 50,
                        color: Colors.white,
                        child: FlatButton(
                          onPressed: () {},
                          splashColor: Color(0xff8df4a0),
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 40,
                                width: 40,
                                child: Icon(
                                  Icons.person_outline,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                'Thông tin & liên hệ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : LoginNotifyWidget(),
      ),
    );
  }
}
