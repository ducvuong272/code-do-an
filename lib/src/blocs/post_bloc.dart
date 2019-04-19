import 'dart:async';

import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';

class PostBloc {
  StreamController<List<Post>> _getAllPostsController =
      StreamController<List<Post>>();
  Stream<List<Post>> get getAllPostStream => _getAllPostsController.stream;

  getAllPost() {
    PostRepository postRepository = PostRepository();
    Future<List<Post>> future = postRepository.getAllPosts();
    future.then(
      (value) {
        _getAllPostsController.sink.add(value);
      },
    );
  }

  dispose() {
    _getAllPostsController.close();
  }
}
