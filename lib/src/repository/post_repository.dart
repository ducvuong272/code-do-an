import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/promotion.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class PostRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<Post>> getAllPostsByCityId(int cityId) async {
    final response = await _apiHandler.getAllPostsByCityId(cityId);
    var listPosts = (json.decode(response)['data'] as List)
        .map((json) => new Post.fromJson(json))
        .toList();
    return listPosts;
  }

  Future<List<Promotion>> getPromotionImageUrls() async {
    final response = await _apiHandler.getPromotionImages();
    List<Promotion> listPromotion = [];
    if (response.statusCode == 200) {
      var map = (json.decode(response.body) as List)
          .map((f) => Promotion.fromJson(f))
          .toList();
      listPromotion = map;
    }
    return listPromotion;
  }

  Future<Map<String, dynamic>> addPost(Post post) async {
    final response = await _apiHandler.addPost(post);
    var map = json.decode(response);
    return map;
  }

  Future<List<Post>> getSavedPost(int userId) async {
    final response = await _apiHandler.getSavedPost(userId);
    List<Post> postList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (map['code'] == 200) {
        var mapToList = (map['data'] as List)
            .map((f) => Post.fromSavedPostJson(f))
            .toList();
        print(mapToList.length);
        postList = mapToList;
      }
    }
    return postList;
  }
}
