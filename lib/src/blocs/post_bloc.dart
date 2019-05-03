import 'dart:async';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';

class PostBloc {
  StreamController<List<Post>> _getAllPostsController =
      StreamController<List<Post>>.broadcast();
  Stream<List<Post>> get getAllPostStream => _getAllPostsController.stream;
  StreamController<List<Post>> _postSearchResultController =
      StreamController<List<Post>>();
  Stream<List<Post>> get getPostSearchResultStream =>
      _postSearchResultController.stream;

  getAllPost() {
    PostRepository postRepository = PostRepository();
    Future<List<Post>> future = postRepository.getAllPosts();
    future.then(
      (value) {
        _getAllPostsController.sink.add(value);
      },
    );
  }

  getPostSearchResult(List<Post> listPostData, String value) {
    
    List<Post> listPostResult = listPostData
        .where((data) =>
            data.postTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
        print(listPostResult.length);
        print(listPostData.length);
        _postSearchResultController.sink.add(listPostResult);
  }

  dispose() {
    _postSearchResultController.close();
    _getAllPostsController.close();
  }
}
