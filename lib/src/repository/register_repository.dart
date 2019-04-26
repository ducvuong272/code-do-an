import 'dart:convert';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';

class RegisterRepository {
  final User user;

  RegisterRepository({this.user});

  ApiHandler _apiHandler = ApiHandler();

  Future<String> signUp() async {
    final response = await _apiHandler.checkSignUp(user);
    Map<String, dynamic> map = jsonDecode(response);
    print(map);
    return map['success'];
  }
}
