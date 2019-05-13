import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
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
  StreamController<Post> _getPostDetailController = StreamController<Post>();
  Stream<Post> get getPostDetailStream => _getPostDetailController.stream;

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

  Future<String> getSavedPostList(int userId) async {
    PostRepository postRepository = PostRepository();
    List<Post> postList = await postRepository.getSavedPost(userId);
    _getSavedPostListController.sink.add(postList);
    return 'ok';
  }

  Future<Null> getAllPostOfUser(int userId) async {
    PostRepository postRepository = PostRepository();
    List<Post> postList = await postRepository.getAllPostOfUser(userId);
    print(postList.length);
    _getAllPostOfUserController.sink.add(postList);
  }

  Future<Null> getPostDetailByPostId(int postId) async {
    PostRepository postRepository = PostRepository();
    Post post = await postRepository.getPostDetailByPostId(postId);
    _getPostDetailController.sink.add(post);
  }

  Future<Null> deleteSavedPostByPostId({
    BuildContext context,
    int postId,
    int userId,
  }) async {
    showDialog<AlertDialog>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Xác nhận xóa địa điểm'),
            content: Text('Bạn muốn xóa địa điểm này ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  CustomDialog dialog = CustomDialog();
                  dialog.showCustomDialog(
                    barrierDismissible: false,
                    context: context,
                    msg: 'Đang tiến hành xóa địa điểm ...',
                    showprogressIndicator: true,
                  );
                  ApiHandler apiHandler = ApiHandler();
                  final response =
                      await apiHandler.deleteSavedPostByPostId(postId, userId);
                  if (response.statusCode == 200) {
                    Map<String, dynamic> map = json.decode(response.body);
                    if (map['code'] == 200) {
                      await getSavedPostList(userId);
                    }
                  }
                },
                child: Text('Xóa địa điểm'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Không'),
              ),
            ],
          ),
    );
  }

  dispose() {
    _promotionImagesController.close();
    _postSearchResultController.close();
    _getAllPostsController.close();
    _getSavedPostListController.close();
    _getAllPostOfUserController.close();
    _getPostDetailController.close();
  }
}
