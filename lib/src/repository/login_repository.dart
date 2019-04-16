import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class LoginRepository {
  final User user;

  LoginRepository(this.user);

  ApiHandler _apiHandler = ApiHandler();

  Future<String> callLoginApi() async {
    var response = await _apiHandler.checkLogin(user);
    Map<String, dynamic> map = jsonDecode(response.toString());
    return map['code'].toString();
  }
}
