import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/models/post.dart';
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

  Future<String> getAllPosts() async {
    final response = await http.get(
      kAllPostsUrl,
      headers: kApiHeader,
    );
    return response.statusCode == 200 ? response.body : 'Lỗi';
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

  Future<String> addPost(Post post) async {
    final apiUrl = kAddPostUrl;
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(
        post.toAddPostJson(),
      ),
    );
    return response.body;
  }
}
