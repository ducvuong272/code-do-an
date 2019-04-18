import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:do_an_tn/src/utils/export_model.dart';
import 'package:do_an_tn/src/constants.dart';

class ApiHandler {
  Future<String> checkLogin(User user) async {
    final apiUrl = kLoginUrl;
    final response = await http.post(
      apiUrl,
      body: json.encode(user.toJson()),
      headers: kApiHeader,
    );
    return response.body;
  }

  Future<String> checkSignUp(User user) async {
    final apiUrl = kSingUpUrl;
    final response = await http.post(
      apiUrl,
      body: json.encode(
        user.toRegisterJson(),
      ),
      headers: kApiHeader,
    );
    return response.body;
  }

  Future<String> getAllPost() async {
    final response = await http.get(
      kAllPostsUrl,
      headers: kApiHeader,
    );
    return response.body;
  }

  Future<String> getUser() async {
    final apiUrl = 'https://projectapi-khanhpham.herokuapp.com/tai-khoan/4';
    final response = await http.get(apiUrl, headers: kApiHeader);
    return response.body;
  }

  Future<String> getAllUsers() async {
    final apiUrl = 'https://projectapi-khanhpham.herokuapp.com/tai-khoan';
    final response = await http.get(apiUrl, headers: kApiHeader);
    return response.body;
  }
}
