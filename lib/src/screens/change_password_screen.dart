import 'package:do_an_tn/src/blocs/change_password_bloc.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:flutter/material.dart';

class ChangeUserPasswordScreen extends StatefulWidget {
  final User user;

  const ChangeUserPasswordScreen({Key key, this.user}) : super(key: key);

  @override
  ChangeUserPasswordScreenState createState() =>
      ChangeUserPasswordScreenState();
}

class ChangeUserPasswordScreenState extends State<ChangeUserPasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  ChangePasswordBloc _bloc = ChangePasswordBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Đổi mật khẩu'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TÊN TÀI KHOẢN: ${widget.user.firstName} ${widget.user.lastName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Mật khẩu cũ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _oldPasswordController,
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Mật khẩu mới',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _newPasswordController,
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'Xác nhận mật khẩu',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        print(_newPasswordController.text);
                        print(_confirmPasswordController.text);
                        _bloc.changePasswordByUserId(
                          widget.user.userId,
                          _oldPasswordController.text,
                          _newPasswordController.text,
                          _confirmPasswordController.text,
                          context,
                        );
                      },
                      child: Text(
                        'Xác nhận',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.redAccent,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
