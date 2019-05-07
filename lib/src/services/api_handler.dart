import 'dart:async';
import 'dart:convert';
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

  Future<String> getAllPosts(int postId) async {
    final apiUrl = '$kAllPostsUrl/$postId';
    final response = await http.get(
      apiUrl,
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

  Future<http.Response> getPromotionImages() async {
    final apiUrl = kPromotionImagesUrl;
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    return response;
  }
}
