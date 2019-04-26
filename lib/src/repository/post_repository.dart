import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class PostRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<Post>> getAllPosts() async {
    var response = await _apiHandler.getAllPosts();
    var listPosts = (json.decode(response) as List)
        .map(
          (json) => new Post.fromJson(json),
        )
        .toList();
    return listPosts;
  }

  Future<Map<String, dynamic>> addPost(Post post) async {
    var response = await _apiHandler.addPost(post);
    var map = json.decode(response);
    print(map);
    return map;
  }
}
