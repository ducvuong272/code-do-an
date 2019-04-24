import 'dart:async';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/repository/register_repository.dart';

class RegisterBloc {
  StreamController<String> _emailController =
      StreamController<String>.broadcast();
  Stream get emailStream => _emailController.stream;
  StreamController<String> _password1Controller = StreamController<String>();
  Stream get password1Stream => _password1Controller.stream;
  StreamController<String> _password2Controller = StreamController<String>();
  Stream get password2Stream => _password2Controller.stream;
  StreamController<String> _usernameController = StreamController<String>();
  Stream get usernameStream => _usernameController.stream;
  StreamController<String> _firstNameController = StreamController<String>();
  Stream get firstNameStream => _firstNameController.stream;
  StreamController<String> _lastNameController = StreamController<String>();
  Stream get lastNameStream => _lastNameController.stream;

  bool isValidInfo(
    String email,
    String firstName,
    String lastName,
    String username,
    String password,
    String checkPassword,
  ) {
    _isValidEmail(email);
    _isValidUsername(username);
    _isValidFirstName(firstName);
    _isValidLastName(lastName);
    _isValidPassword(password);
    _isValidCheckPassword(password, checkPassword);
    return _isValidEmail(email) &&
            _isValidUsername(username) &&
            _isValidFirstName(firstName) &&
            _isValidLastName(lastName) &&
            _isValidPassword(password) &&
            _isValidCheckPassword(
              password,
              checkPassword,
            )
        ? true
        : false;
  }

  _isValidEmail(String email) {
    if (email.trim() == '') {
      _emailController.sink.addError('Email không được để trống');
      return false;
    } else if (!email.contains('@')) {
      _emailController.sink.addError('Email không hợp lệ');
      return false;
    }
    _emailController.sink.add('OK');
    return true;
  }

  _isValidUsername(String username) {
    if (username.trim() == '') {
      _usernameController.sink.addError('Tên đăng nhập không được để trống');
      return false;
    } else if (username.contains(' ')) {
      _usernameController.sink
          .addError('Tên đăng nhập không được chứa dấu cách');
      return false;
    }
    _usernameController.sink.add('OK');
    return true;
  }

  _isValidFirstName(String firstName) {
    if (firstName.trim() == '') {
      _firstNameController.sink.addError('Họ không được để trống');
      return false;
    }
    _firstNameController.sink.add('OK');
    return true;
  }

  _isValidLastName(String lastName) {
    if (lastName.trim() == '') {
      _lastNameController.sink.addError('Tên không được để trống');
      return false;
    }
    _lastNameController.sink.add('OK');
    return true;
  }

  _isValidPassword(String password) {
    if (password == '') {
      _password1Controller.sink.addError('Mật khẩu không được để trống');
      return false;
    } else if (password.contains(' ')) {
      _password1Controller.sink.addError('Mật khẩu không được chứa dấu cách');
      return false;
    }
    _password1Controller.sink.add('OK');
    return true;
  }

  _isValidCheckPassword(String password, String checkPassword) {
    if (checkPassword == '') {
      _password2Controller.sink.addError('Mật khẩu không được để trống');
      return false;
    } else if (checkPassword != password) {
      _password2Controller.sink.addError('Nhập lại mật khẩu không chính xác');
      return false;
    }
    _password2Controller.sink.add('OK');
    return true;
  }

  signUp(User user, BuildContext context) {
    RegisterRepository registerBloc = RegisterRepository(user: user);
    Future<String> future = registerBloc.signUp();
    future.then((onValue) {
      CustomDialog dialog = CustomDialog();
      dialog.hideCustomDialog(context);
      dialog.showCustomDialog(
        barrierDismissible: true,
        msg: onValue,
        context: context,
        showprogressIndicator: false,
      );
    });
  }

  dispose() {
    _emailController.close();
    _password1Controller.close();
    _password2Controller.close();
    _firstNameController.close();
    _usernameController.close();
    _lastNameController.close();
  }
}
