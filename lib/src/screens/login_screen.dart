import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignUpTapped, onForgetPassTapped;

  const LoginScreen({
    Key key,
    this.onSignUpTapped,
    this.onForgetPassTapped,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _passwordInvisible = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 350,
              margin: EdgeInsets.fromLTRB(30, 150, 30, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white70,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.person_outline,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          'Tên đăng nhập',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      autocorrect: false,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        suffix: GestureDetector(
                          child: Icon(
                            Icons.clear,
                          ),
                          onTap: () => _userNameController.clear(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Icon(
                          Icons.lock_outline,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Mật khẩu',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: TextField(
                      obscureText: _passwordInvisible,
                      autocorrect: false,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordInvisible = !_passwordInvisible;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _passwordController.clear(),
                              child: Icon(
                                Icons.clear,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff50ce5f),
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      width: 250,
                      child: Center(
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      widget.onForgetPassTapped();
                    },
                    child: Text(
                      'Quên mật khẩu ?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Hoặc',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff557ce0),
                    onPressed: () {
                      widget.onSignUpTapped();
                    },
                    child: Container(
                      height: 50,
                      width: 250,
                      child: Center(
                        child: Text(
                          'Tại tài khoản mới',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
