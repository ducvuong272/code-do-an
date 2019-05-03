import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:do_an_tn/src/models/comment.dart';
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

  Future<String> addPost(Post post) async {
    final apiUrl = kAddPostUrl;
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(post.toAddPostJson()),
    );
    print(json.encode(post.toAddPostJson()));
    return response.body;
  }

  Future<String> postComment(Comment comment) async {
    final apiUrl = kPostCommentUrl;
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(comment.toPostCommentJson()),
    );
    return response.body;
  }

  Future<String> postImage(File a) async {
    var apiurl = "$kApiUrl/tai-hinh";
    Map<String, dynamic> map = Map<String, dynamic>();
    var image = base64Encode(a.readAsBytesSync());
    print("base64: " + image);
    map["Id_DiaDiem"] = 1;
    map["image"] = a;
    print(apiurl);
    print(map);
    var response =await http.post(
      apiurl,
      headers: kApiHeader,
      body: json.encode(a),
    );
    print('response: '+response.body);
    return response.body;
  }
}
