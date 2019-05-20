import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:http/http.dart' as http;
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

  Future<String> getAllPostsByCityId(int cityId) async {
    final apiUrl = '$kAllPostsUrl/$cityId';
    print(apiUrl);
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    print(response.body);
    return response.statusCode == 200 ? response.body : 'Lỗi';
  }

  Future<String> addPost(Post post) async {
    final apiUrl = kAddPostUrl;
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(post.toAddPostJson()),
    );
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

  Future<http.Response> savePost(Map<String, int> savePostMap) async {
    final apiUrl = kSavePostUrl;
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(savePostMap),
    );
    return response;
  }

  Future<http.Response> sendEmailToGetPassword(String email) async {
    final apiUrl = kForgetPasswordUrl;
    Map<String, String> emailMap = {"Email": "$email"};
    final response = await http.post(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(emailMap),
    );
    return response;
  }

  Future<http.Response> getSavedPost(int userId) async {
    final apiUrl = '$kGetSavedPostUrl/$userId';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getAllPostOfUser(int userId) async {
    final apiUrl = '$kGetAllPostOfUser/$userId';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getAllPostCategory() async {
    final apiUrl = '$kgetAllPostCategory';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getAllCity() async {
    final apiUrl = '$kgetAllCity';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    return response;
  }

  Future<http.Response> getDistrictByCityId(int cityId) async {
    final apiUrl = '$kgetDistrictByCity/$cityId';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    return response;
  }

  Future<http.Response> getPostDetailByPostId(int postId) async {
    final apiUrl = '$kGetPostDetailByPostId/$postId';
    final response = await http.get(
      apiUrl,
      headers: kApiHeader,
    );
    return response;
  }

  Future<http.Response> deleteSavedPostByPostId(int postId, int userId) async {
    final apiUrl = '$kDeleteSavedPostByPostId/$postId';
    final client = http.Client();
    final response = await client.send(http.Request('DELETE', Uri.parse(apiUrl))
      ..headers["Content-Type"] = "application/json"
      ..body = json.encode({"Id_TaiKhoan": userId}));
    http.Response result = await http.Response.fromStream(response);
    print(result.body);
    return result;
  }

  Future<http.Response> changePasswordById(
    int userId,
    String oldPassword,
    String newPassword,
  ) async {
    final apiUrl = '$kChangePasswordByUserId/$userId';
    Map<String, dynamic> changePasswordMap = {
      "MatKhauCu": "$oldPassword",
      "MatKhauMoi": "$newPassword"
    };
    print(changePasswordMap);
    final response = await http.put(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(changePasswordMap),
    );
    return response;
  }

  Future<http.Response> updateUserInformationByUserId(User user) async {
    final apiUrl = '$kUpdateUserInformationByUserId/${user.userId}';
    final response = await http.put(
      apiUrl,
      headers: kApiHeader,
      body: json.encode(user.toUpdateUserInfoJson()),
    );
    return response;
  }

  Future<http.Response> deletePostByPostId(int postId) async {
    final apiUrl = '$kDeleteUserPost/$postId';
    final response = await http.delete(
      apiUrl,
      headers: kApiHeader,
    );
    print(response.body);
    return response;
  }
}
