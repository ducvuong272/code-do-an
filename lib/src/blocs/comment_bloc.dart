import 'dart:async';
import 'dart:io';
import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/services/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
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
  StreamController<List<File>> _listImageController =
      StreamController<List<File>>();
  Stream<List<File>> get imageFilesStream => _listImageController.stream;

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

  Future<File> _pickImage() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  addImageToList(List<File> listImage) {
    _pickImage().then((onValue) {
      if (onValue != null) {
        listImage.add(onValue);
        _listImageController.sink.add(listImage);
      }
    });
  }

  removeImage(List<File> listImage, int index) {
    listImage.removeAt(index);
    _listImageController.sink.add(listImage);
  }

  Future<List<String>> _uploadImageToFirebase(List<File> listImage) async {
    FirebaseServices firebaseServices = FirebaseServices();
    List<String> imageUriList = [];
    for (int i = 0; i < listImage.length; i++) {
      imageUriList.add(
          await firebaseServices.uploadImageToFireBaseStorage(listImage[i]));
    }
    print(imageUriList);
    return imageUriList;
  }

  postComment(
    BuildContext context,
    Comment comment,
    PostBloc postBloc,
    int postId,
    List<File> commentImageList,
  ) {
    CustomDialog dialog = CustomDialog();
    if (comment.commentContent.trim() == '') {
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Bình luận không được để trống',
        showprogressIndicator: false,
      );
    } else {
      dialog.showCustomDialog(
        context: context,
        barrierDismissible: false,
        msg: 'Đang xử lý...',
        showprogressIndicator: true,
      );
      if (commentImageList.isNotEmpty) {
        _uploadImageToFirebase(commentImageList).then((onValue) {
          comment.commentImageUrlList = onValue;
          CommentRepository commentRepository =
              CommentRepository(comment: comment);
          Future future = commentRepository.postComment();
          future.then((onValue) async {
            if (onValue == "200") {
              await postBloc.getPostDetailByPostId(postId);
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
        });
      } else {
        comment.commentImageUrlList = [];
        CommentRepository commentRepository =
            CommentRepository(comment: comment);
        Future future = commentRepository.postComment();
        future.then((onValue) async {
          if (onValue == "200") {
            await postBloc.getPostDetailByPostId(postId);
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
    }
  }

  dispose() {
    _locationRatingController.close();
    _priceRatingController.close();
    _qualityRatingController.close();
    _serviceRatingController.close();
    _viewRatingController.close();
    _listImageController.close();
  }
}
