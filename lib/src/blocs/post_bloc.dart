import 'dart:async';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

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
  StreamController<List<Post>> _getSavedPostListController =
      StreamController<List<Post>>();
  Stream<List<Post>> get getSavedPostListStream =>
      _getSavedPostListController.stream;
  StreamController<List<Post>> _getAllPostOfUserController =
      StreamController<List<Post>>();
  Stream<List<Post>> get getAllPostOfUserStream =>
      _getAllPostOfUserController.stream;

  Future<Null> getAllPostByCityId(
    BuildContext context,
    int cityId,
    bool showDialog,
  ) async {
    CustomDialog customDialog = CustomDialog();
    if (showDialog) {
      customDialog.showCustomDialog(
        context: context,
        barrierDismissible: false,
        msg: 'Đang load địa điểm...',
        showprogressIndicator: true,
      );
    }
    PostRepository postRepository = PostRepository();
    await postRepository.getAllPostsByCityId(cityId).then((onValue) {
      _getAllPostsController.sink.add(onValue);
      if (showDialog) customDialog.hideCustomDialog(context);
    });
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

  Future<Null> getSavedPostList(int userId) async {
    PostRepository postRepository = PostRepository();
    List<Post> postList = await postRepository.getSavedPost(userId);
    print(postList.length);
    _getSavedPostListController.sink.add(postList);
  }

  Future<Null> getAllPostOfUser(int userId) async {
    PostRepository postRepository = PostRepository();
    List<Post> postList = await postRepository.getAllPostOfUser(userId);
    print(postList.length);
    _getAllPostOfUserController.sink.add(postList);
  }

  dispose() {
    _promotionImagesController.close();
    _postSearchResultController.close();
    _getAllPostsController.close();
    _getSavedPostListController.close();
    _getAllPostOfUserController.close();
  }
}
