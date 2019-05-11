import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:do_an_tn/src/constants.dart';
import 'package:path/path.dart';

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

  // Future<http.Response> fetchCityByWithId() async {
  //   final apiUrl = kGetCityWithIdUrl;
  //   final response = await http.get(
  //     apiUrl,
  //     headers: kApiHeader,
  //   );
  //   return response;
  // }

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

  Future<http.StreamedResponse> uploadPostImage(File imageFile) async {
    final apiUrl = '$kUpLoadPostImage';
    var uri = Uri.parse(apiUrl);
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    await http.Response.fromStream(response).then((onValue) => onValue.body);
    return response;
  }
}
