import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback haveAccountTapped;

  const SignUpScreen({
    Key key,
    this.haveAccountTapped,
  }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  bool _passwordInvisible1 = true, _passwordInvisible2 = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 600,
              margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xff96e8f2),
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
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Icon(
                          Icons.mail_outline,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Email',
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        suffix: GestureDetector(
                          child: Icon(
                            Icons.clear,
                          ),
                          onTap: () => _emailController.clear(),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Icon(
                          Icons.lock_outline,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
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
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      obscureText: _passwordInvisible1,
                      autocorrect: false,
                      controller: _passwordController1,
                      decoration: InputDecoration(
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordInvisible1 = !_passwordInvisible1;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _passwordController1.clear(),
                              child: Icon(
                                Icons.clear,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Icon(
                          Icons.lock_outline,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Nhập lại mật khẩu',
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
                      obscureText: _passwordInvisible2,
                      autocorrect: false,
                      controller: _passwordController2,
                      decoration: InputDecoration(
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _passwordInvisible2 = !_passwordInvisible2;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _passwordController2.clear(),
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
                    color: Color(0xff557ce0),
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      width: 250,
                      child: Center(
                        child: Text(
                          'Đăng ký',
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        widget.haveAccountTapped();
                      },
                      child: Text(
                        'Đã có tài khoản ?',
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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
