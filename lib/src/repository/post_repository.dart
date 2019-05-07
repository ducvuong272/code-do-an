import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/promotion.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class PostRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<Post>> getAllPosts(int postId) async {
    final response = await _apiHandler.getAllPosts(postId);
    var listPosts = (json.decode(response) as List)
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
}
