import 'dart:async';
import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';
import 'package:do_an_tn/src/services/firebase_services.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPostBloc {
  StreamController<TimeOfDay> _openTimeController =
      StreamController<TimeOfDay>();
  Stream<TimeOfDay> get openTimeStream => _openTimeController.stream;
  StreamController<TimeOfDay> _closeTimeController =
      StreamController<TimeOfDay>();
  Stream<TimeOfDay> get closeTimeStream => _closeTimeController.stream;
  StreamController<List<Map<String, dynamic>>> _getAllPostCategoryController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get getAllPostCategoryStream =>
      _getAllPostCategoryController.stream;
  StreamController<List<Map<String, dynamic>>> _getAllCityController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get getAllCityStream =>
      _getAllCityController.stream;
  StreamController<File> _getImageFileController = StreamController<File>();
  Stream<File> get getImageFileStream => _getImageFileController.stream;

  setOpenTimePicked(
    BuildContext context,
    TimeOfDay time,
  ) async {
    Future<TimeOfDay> future = showTimePicker(
      context: context,
      initialTime: time,
    );
    future.then((onValue) {
      if (onValue != null && onValue != time) {
        _openTimeController.sink.add(onValue);
      }
    });
  }

  setCloseTimePicked(
    BuildContext context,
    TimeOfDay time,
  ) {
    Future<TimeOfDay> future = showTimePicker(
      context: context,
      initialTime: time,
    );
    future.then((onValue) {
      if (onValue != null && onValue != time) {
        _closeTimeController.sink.add(onValue);
      }
    });
  }

  _pickImageFromCamera(BuildContext context) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      _getImageFileController.sink.add(imageFile);
    }
  }

  Future<Null> _pickImageFromAlbum(BuildContext context) async {
    Navigator.pop(context);
    await ImagePicker.pickImage(source: ImageSource.gallery).then((onValue) {
      if (onValue != null) {
        _getImageFileController.sink.add(onValue);
      }
    });
  }

  showOptionsToPickImage({
    Dialog dialog,
    BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bạn muốn thêm hình ảnh từ đâu?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => _pickImageFromAlbum(context),
                child: Text('Album ảnh'),
              ),
              FlatButton(
                onPressed: () => _pickImageFromCamera(context),
                child: Text('Máy ảnh'),
              ),
            ],
          );
        });
  }

  addPost(
    Post post,
    BuildContext context,
    CustomDialog dialog,
    File imageFile,
    PostBloc postBloc,
    int userId,
  ) async {
    print(post.phoneNumber);
    print(post.highestPrice);
    print(post.lowestPrice);
    print(post.postDetail);
    if (post.address.trim() == '' ||
        post.postTitle.trim() == '' ||
        post.phoneNumber == '' ||
        post.highestPrice == '' ||
        post.lowestPrice == '' ||
        post.postDetail == '') {
      dialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: 'Vui lòng điền đầy đủ thông tin',
          showprogressIndicator: false);
    }
     else {
      dialog.showCustomDialog(
        msg: 'Đang tiến hành thêm địa điểm',
        barrierDismissible: false,
        context: context,
        showprogressIndicator: true,
      );
      PostRepository postRepository = PostRepository();
      FirebaseServices firebaseServices = FirebaseServices();
      String imageUri =
          await firebaseServices.uploadImageToFireBaseStorage(imageFile);
      post.imageUrl = imageUri;
      print(imageUri);
      Future future = postRepository.addPost(post);
      future.then((onValue) {
        print(onValue["success"]);
        if (onValue['code'] == 200) {
          print(userId);
          postBloc.getAllPostOfUser(userId);
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            msg: onValue['success'],
            barrierDismissible: true,
            context: context,
            showprogressIndicator: false,
          );
        } else {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            msg: onValue['success'],
            barrierDismissible: true,
            context: context,
            showprogressIndicator: false,
          );
        }
      });
    }
  }

  Future<Null> getAllPostCategory() async {
    PostRepository postRepository = PostRepository();
    List<Map<String, dynamic>> listCateGoryMap =
        await postRepository.getAllPostCategory();
    _getAllPostCategoryController.sink.add(listCateGoryMap);
  }

  Future<Null> getAllCity() async {
    PostRepository postRepository = PostRepository();
    List<Map<String, dynamic>> listCityMap = await postRepository.getAllCity();
    _getAllCityController.sink.add(listCityMap);
  }

  Future<List<String>> getDistrictByCityId(
      BuildContext context, int cityId) async {
    // CustomDialog dialog = CustomDialog();
    // dialog.showCustomDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   msg: '',
    //   showprogressIndicator: true,
    // );
    PostRepository postRepository = PostRepository();
    List<String> districtList = [];
    await postRepository.getDistrictByCityId(cityId).then((onValue) {
      // dialog.hideCustomDialog(context);
      districtList = onValue;
    });
    return districtList;
  }

  dispose() {
    _openTimeController.close();
    _closeTimeController.close();
    _getAllPostCategoryController.close();
    _getAllCityController.close();
    _getImageFileController.close();
  }
}
