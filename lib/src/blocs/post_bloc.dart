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
  StreamController<List<String>> _promotionImagesController =
      StreamController<List<String>>();
  Stream<List<String>> get promotionImageStream =>
      _promotionImagesController.stream;

  Future<Null> getAllPost(int filterId) async {
    PostRepository postRepository = PostRepository();
    Future<List<Post>> future = postRepository.getAllPosts(filterId);
    future.then(
      (value) {
        _getAllPostsController.sink.add(value);
      },
    );
  }

  instantSearchPost(List<Post> listPostData, String value) {
    List<Post> listPostResult = listPostData
        .where((data) =>
            data.postTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
    print(listPostResult.length);
    print(listPostData.length);
    _postSearchResultController.sink.add(listPostResult);
  }

  Future<Null> getPromotionImages() async {
    PostRepository postRepository = PostRepository();
    List<String> imageList = [];
    final listPromotion = await postRepository.getPromotionImageUrls();
    for (int i = 0; i < listPromotion.length; i++) {
      imageList.add(listPromotion[i].imageUrl);
    }
    _promotionImagesController.sink.add(imageList);
  }

  dispose() {
    _promotionImagesController.close();
    _postSearchResultController.close();
    _getAllPostsController.close();
  }
}
