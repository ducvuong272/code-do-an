import 'package:do_an_tn/src/blocs/register_bloc.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  bool _passwordInvisible1 = true, _passwordInvisible2 = true;
  RegisterBloc _registerBloc = RegisterBloc();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.fromLTRB(30, 50, 30, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xff96e8f2),
                ),
                child: Column(
                  children: <Widget>[
                    StreamBuilder<Object>(
                      stream: _registerBloc.usernameStream,
                      builder: (context, snapshot) {
                        return _informationSection(
                          text: 'Tên đăng nhập',
                          textController: _userNameController,
                          iconData: Icons.person_outline,
                          error: snapshot.hasError ? '${snapshot.error}' : null,
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: StreamBuilder<Object>(
                        stream: _registerBloc.nameStream,
                        builder: (context, snapshot) {
                          return _informationSection(
                            text: 'Họ tên',
                            textController: _nameController,
                            iconData: Icons.menu,
                            error:
                                snapshot.hasError ? '${snapshot.error}' : null,
                          );
                        },
                      ),
                    ),
                    StreamBuilder<Object>(
                      stream: _registerBloc.emailStream,
                      builder: (context, snapshot) {
                        return _informationSection(
                          text: 'Email',
                          iconData: Icons.mail_outline,
                          textController: _emailController,
                          error: snapshot.hasError ? '${snapshot.error}' : null,
                        );
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: StreamBuilder<Object>(
                          stream: _registerBloc.password1Stream,
                          builder: (context, snapshot) {
                            return TextField(
                              style: TextStyle(fontSize: 20),
                              obscureText: _passwordInvisible1,
                              autocorrect: false,
                              controller: _passwordController1,
                              decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? '${snapshot.error}'
                                    : null,
                                errorStyle: TextStyle(fontSize: 15),
                                contentPadding: EdgeInsets.all(0),
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _passwordInvisible1 =
                                                !_passwordInvisible1;
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
                            );
                          }),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                      child: StreamBuilder<Object>(
                          stream: _registerBloc.password2Stream,
                          builder: (context, snapshot) {
                            return TextField(
                              style: TextStyle(fontSize: 20),
                              obscureText: _passwordInvisible2,
                              autocorrect: false,
                              controller: _passwordController2,
                              decoration: InputDecoration(
                                errorText: snapshot.hasError
                                    ? '${snapshot.error}'
                                    : null,
                                errorStyle: TextStyle(fontSize: 15),
                                contentPadding: EdgeInsets.all(0),
                                suffix: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _passwordInvisible2 =
                                                !_passwordInvisible2;
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
                            );
                          }),
                    ),
                    RaisedButton(
                      color: Color(0xff557ce0),
                      onPressed: () {
                        var _isValidInfo = _registerBloc.isValidInfo(
                          _emailController.text,
                          _nameController.text,
                          _userNameController.text,
                          _passwordController1.text,
                          _passwordController2.text,
                        );
                        if (_isValidInfo) {
                          CustomDialog dialog = CustomDialog();
                          dialog.showCustomDialog(
                            barrierDismissible: true,
                            showprogressIndicator: true,
                            msg: 'Đang tiến hành đăng ký...',
                            context: context,
                          );
                          User user = User(
                            username: _userNameController.text,
                            password: _passwordController1.text,
                            name: _nameController.text,
                            email: _emailController.text,
                          );
                          _registerBloc.signUp(user, context);
                        }
                      },
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
        ),
      ],
    );
  }

  Widget _informationSection({
    String text,
    TextEditingController textController,
    IconData iconData,
    String error,
  }) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Icon(
                iconData,
                size: 50,
                color: Colors.black,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: TextField(
            style: TextStyle(
              fontSize: 20,
            ),
            autocorrect: false,
            controller: textController,
            decoration: InputDecoration(
              errorText: error != null ? error : null,
              errorStyle: TextStyle(fontSize: 15),
              contentPadding: EdgeInsets.all(0),
              suffix: GestureDetector(
                child: Icon(
                  Icons.clear,
                ),
                onTap: () => textController.clear(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }
}
