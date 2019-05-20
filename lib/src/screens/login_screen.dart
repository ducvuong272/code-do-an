import 'package:do_an_tn/src/blocs/login_bloc.dart';
import 'package:do_an_tn/src/services/check_network_connectivity.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
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
  FocusNode _usernameFocusNode = FocusNode(), _passwordFocusNode = FocusNode();
  LoginBloc _loginBloc = LoginBloc();

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
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
                    child: StreamBuilder<Object>(
                        stream: _loginBloc.usernameStream,
                        builder: (context, snapshot) {
                          return TextField(
                            style: TextStyle(fontSize: 25),
                            autocorrect: false,
                            controller: _userNameController,
                            focusNode: _usernameFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                              _passwordController.selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: _passwordController.text.length,
                              );
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              suffix: GestureDetector(
                                child: Icon(
                                  Icons.clear,
                                ),
                                onTap: () => _userNameController.clear(),
                              ),
                            ),
                          );
                        }),
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
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: StreamBuilder<Object>(
                        stream: _loginBloc.passwordStream,
                        builder: (context, snapshot) {
                          return TextField(
                            style: TextStyle(fontSize: 25),
                            obscureText: _passwordInvisible,
                            autocorrect: false,
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              suffix: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _passwordInvisible =
                                              !_passwordInvisible;
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
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: Color(0xff50ce5f),
                    onPressed: () {
                      NetworkConnection()
                          .checkNetworkConnectivity(context)
                          .then((onValue) {
                        if (onValue == true) {
                          CustomDialog _dialog = CustomDialog();
                          _loginBloc.login(
                            _userNameController.text.trim(),
                            _passwordController.text,
                            context,
                            _dialog,
                          );
                        }
                      });
                    },
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
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      color: Color(0xff557ce0),
                      onPressed: () {
                        widget.onSignUpTapped();
                      },
                      child: Container(
                        height: 50,
                        width: 250,
                        child: Center(
                          child: Text(
                            'Tạo tài khoản mới',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
