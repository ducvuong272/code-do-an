import 'dart:async';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/repository/comment_repository.dart';

class CommentBloc {
  StreamController<int> _locationRatingController = StreamController<int>();
  Stream<int> get locationRatingStream => _locationRatingController.stream;
  StreamController<int> _priceRatingController = StreamController<int>();
  Stream<int> get priceRatingStream => _priceRatingController.stream;
  StreamController<int> _qualityRatingController = StreamController<int>();
  Stream<int> get qualityRatingStream => _qualityRatingController.stream;
  StreamController<int> _serviceRatingController = StreamController<int>();
  Stream<int> get serviceRatingStream => _serviceRatingController.stream;
  StreamController<int> _viewRatingController = StreamController<int>();
  Stream<int> get viewRatingStream => _viewRatingController.stream;

  // Future<List<Asset>> pickImages() async {
  //   List<Asset> resultList = List<Asset>();
  //   resultList = await MultiImagePicker.pickImages(
  //     maxImages: 50,
  //     enableCamera: true,
  //     cupertinoOptions: CupertinoOptions(takePhotoIcon: 'pick'),
  //     materialOptions: MaterialOptions(),
  //   );
  //   return resultList;
  // }

  postComment(BuildContext context, Comment comment) {
    CustomDialog dialog = CustomDialog();
    dialog.showCustomDialog(
      context: context,
      barrierDismissible: false,
      msg: 'Đang xử lý...',
      showprogressIndicator: true,
    );
    CommentRepository commentRepository = CommentRepository(comment: comment);
    Future future = commentRepository.postComment();
    future.then((onValue) {
      if (onValue == "200") {
        dialog.hideCustomDialog(context);
        dialog.showCustomDialog(
          context: context,
          barrierDismissible: true,
          msg: 'Đăng bình luận thành công!',
          showprogressIndicator: false,
        );
      } else {
        dialog.hideCustomDialog(context);
        dialog.showCustomDialog(
          context: context,
          barrierDismissible: true,
          msg: 'Đăng bình luận thất bại!',
          showprogressIndicator: false,
        );
      }
    });
  }

  dispose() {
    _locationRatingController.close();
    _priceRatingController.close();
    _qualityRatingController.close();
    _serviceRatingController.close();
    _viewRatingController.close();
  }
}
