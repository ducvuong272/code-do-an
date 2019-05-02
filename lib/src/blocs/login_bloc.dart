import 'dart:async';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/repository/login_repository.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

class LoginBloc {
  StreamController<String> _usernameController = StreamController<String>();
  Stream<String> get usernameStream => _usernameController.stream;
  StreamController<String> _passwordController = StreamController<String>();
  Stream<String> get passwordStream => _passwordController.stream;

  login(
    String username,
    String password,
    BuildContext context,
    CustomDialog dialog,
  ) {
    var isValidInfo = _checkValidInfo(username, password);
    if (isValidInfo) {
      dialog.showCustomDialog(
        context: context,
        msg: 'Đang tiến hành đăng nhập...',
        barrierDismissible: false,
        showprogressIndicator: true,
      );
      final user = User(
        username: username,
        password: password,
      );
      LoginRepository _loginRepository = LoginRepository(user);
      Future<Map<String, dynamic>> future = _loginRepository.callLoginApi();
      future.then((onValue) {
        if (onValue['code'].toString() == '200') {
          User userLoggedIn = User.fromJson(onValue['data']);
          _onLoginSuccess(context, dialog, userLoggedIn);
        } else {
          _onLoginFail(context, dialog);
        }
      });
    }
  }

  _onLoginSuccess(BuildContext context, CustomDialog dialog, User user) {
    dialog.hideCustomDialog(context);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(user: user),
        ),
        (Route<dynamic> route) => false);
  }

  _onLoginFail(
    BuildContext context,
    CustomDialog dialog,
  ) {
    dialog.hideCustomDialog(context);
    dialog.showCustomDialog(
      barrierDismissible: true,
      context: context,
      msg: 'Đăng nhập không thành công!',
      showprogressIndicator: false,
    );
  }

  bool _isValidUsername(String username) {
    if (username.trim() == '') {
      _usernameController.sink.addError('Tên đăng nhập không được để trống!');
      return false;
    }
    _usernameController.sink.add('OK');
    return true;
  }

  bool _isValidPassword(String password) {
    if (password.trim() == '') {
      _passwordController.sink.addError('Mật khẩu không được để trống!');
      return false;
    }
    _passwordController.sink.add('OK');
    return true;
  }

  bool _checkValidInfo(String username, String password) {
    bool isValidUsername = _isValidUsername(username);
    bool isValidPassword = _isValidPassword(password);
    return isValidUsername && isValidPassword ? true : false;
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
  }
}
