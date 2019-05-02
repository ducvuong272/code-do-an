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
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();
  FocusNode _userNameFocusnode = FocusNode(),
      _emailFocusNode = FocusNode(),
      _firstNameFocusNode = FocusNode(),
      _lastNameFocusNode = FocusNode(),
      _password1FocusNode = FocusNode(),
      _password2FocusNode = FocusNode();
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
          child: Container(
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
                      context: context,
                      nextNode: _firstNameFocusNode,
                      currentNode: _userNameFocusnode,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: StreamBuilder<Object>(
                    stream: _registerBloc.firstNameStream,
                    builder: (context, snapshot) {
                      return _informationSection(
                        text: 'Họ',
                        textController: _firstNameController,
                        iconData: Icons.list,
                        error:
                            snapshot.hasError ? '${snapshot.error}' : null,
                        context: context,
                        nextNode: _lastNameFocusNode,
                        currentNode: _firstNameFocusNode,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: StreamBuilder<Object>(
                    stream: _registerBloc.lastNameStream,
                    builder: (context, snapshot) {
                      return _informationSection(
                        textController: _lastNameController,
                        text: 'Tên',
                        iconData: Icons.list,
                        error:
                            snapshot.hasError ? '${snapshot.error}' : null,
                        context: context,
                        nextNode: _emailFocusNode,
                        currentNode: _lastNameFocusNode,
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
                      context: context,
                      nextNode: _password1FocusNode,
                      currentNode: _emailFocusNode,
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  margin: EdgeInsets.only(top: 20),
                  child: StreamBuilder<Object>(
                      stream: _registerBloc.password1Stream,
                      builder: (context, snapshot) {
                        return TextField(
                          style: TextStyle(fontSize: 20),
                          obscureText: _passwordInvisible1,
                          autocorrect: false,
                          controller: _passwordController1,
                          focusNode: _password1FocusNode,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_password2FocusNode);
                          },
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? '${snapshot.error}'
                                : null,
                            errorStyle: TextStyle(fontSize: 15),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.lock_outline,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Mật khẩu',
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
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
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
                  margin: EdgeInsets.only(top: 20),
                  child: StreamBuilder<Object>(
                      stream: _registerBloc.password2Stream,
                      builder: (context, snapshot) {
                        return TextField(
                          style: TextStyle(fontSize: 20),
                          obscureText: _passwordInvisible2,
                          autocorrect: false,
                          controller: _passwordController2,
                          focusNode: _password2FocusNode,
                          decoration: InputDecoration(
                            errorText: snapshot.hasError
                                ? '${snapshot.error}'
                                : null,
                            contentPadding: EdgeInsets.all(0),
                            errorStyle: TextStyle(fontSize: 15),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.lock_outline,
                                size: 50,
                                color: Colors.black,
                              ),
                            ),
                            labelText: 'Nhập lại mật khẩu',
                            labelStyle: TextStyle(
                              fontSize: 20,
                            ),
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
                      _firstNameController.text,
                      _lastNameController.text,
                      _userNameController.text,
                      _passwordController1.text,
                      _passwordController2.text,
                    );
                    if (_isValidInfo) {
                      CustomDialog dialog = CustomDialog();
                      dialog.showCustomDialog(
                        barrierDismissible: false,
                        showprogressIndicator: true,
                        msg: 'Đang tiến hành đăng ký...',
                        context: context,
                      );
                      User user = User(
                        username: _userNameController.text,
                        password: _passwordController1.text,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
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
        ),
      ],
    );
  }

  Widget _informationSection({
    String text,
    TextEditingController textController,
    IconData iconData,
    String error,
    BuildContext context,
    FocusNode nextNode,
    FocusNode currentNode,
  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        style: TextStyle(
          fontSize: 20,
        ),
        autocorrect: false,
        controller: textController,
        focusNode: currentNode,
        onEditingComplete: () {
          nextNode != null
              ? FocusScope.of(context).requestFocus(nextNode)
              : FocusScope.of(context).requestFocus(FocusNode());
        },
        decoration: InputDecoration(
          errorText: error != null ? error : null,
          errorStyle: TextStyle(fontSize: 15),
          contentPadding: EdgeInsets.all(0),
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              iconData,
              size: 50,
              color: Colors.black,
            ),
          ),
          suffix: GestureDetector(
            child: Icon(
              Icons.clear,
            ),
            onTap: () => textController.clear(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }
}
