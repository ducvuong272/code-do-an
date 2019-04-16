import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/repository/login_repository.dart';

class LoginBloc {
  StreamController<String> _usernameController = StreamController<String>();
  Stream<String> get usernameStream => _usernameController.stream;
  StreamController<String> _passwordController = StreamController<String>();
  Stream<String> get passwordStream => _passwordController.stream;

  login(
    String username,
    String password,
    Function onLoginSuccess,
    Function onLoginFail,
  ) {
    final user = User(userName: username, password: password);
    LoginRepository _loginRepository = LoginRepository(user);
    Future<String> future = _loginRepository.callLoginApi();
    future.then((onValue) {
      if (onValue == '200') {
        onLoginSuccess();
        // print('success');
      } else {
        // print('fail');
        onLoginFail();
      }
    });
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
  }
}

final loginBloc = LoginBloc();
