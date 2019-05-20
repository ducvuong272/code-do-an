import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/services/firebase_services.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserInfoBloc {
  StreamController<User> _userController = StreamController<User>();
  Stream<User> get userStream => _userController.stream;
  StreamController<File> _getImageFileController = StreamController<File>();
  Stream<File> get getImageFileStream => _getImageFileController.stream;
  ApiHandler _apiHandler = ApiHandler();

  Future<Null> pickImageFromAlbum() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((onValue) {
      if (onValue != null) {
        _getImageFileController.sink.add(onValue);
      }
    });
  }

  updateUserInfor(User user, BuildContext context, File imageFile) async {
    if (user.firstName == null ||
        user.firstName.trim() == '' ||
        user.lastName == null ||
        user.lastName.trim() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Họ tên không được để trống !'),
                title: Text('Lỗi'),
              ));
    } else if (user.email == null || user.email.trim() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Email không được để trống !'),
                title: Text('Lỗi'),
              ));
    } else {
      String imageUri = '';
      CustomDialog dialog = CustomDialog();
      dialog.showCustomDialog(
        barrierDismissible: false,
        context: context,
        msg: 'Đang xử lý...',
        showprogressIndicator: true,
      );
      if (imageFile != null) {
        FirebaseServices firebaseServices = FirebaseServices();
        imageUri =
            await firebaseServices.uploadImageToFireBaseStorage(imageFile);
        user.imageUrl = imageUri;
        final response = await _apiHandler.updateUserInformationByUserId(user);
        if (response.statusCode == 200) {
          Map<String, dynamic> map = json.decode(response.body);
          if (map['code'] == 200) {
            // _userController.sink.add(user);
            dialog.hideCustomDialog(context);
            dialog.showCustomDialog(
              barrierDismissible: true,
              context: context,
              msg: 'Cập nhật thông tin tài khoản thành công!',
              showprogressIndicator: false,
            );
          } else {
            dialog.hideCustomDialog(context);
            dialog.showCustomDialog(
              barrierDismissible: true,
              context: context,
              msg: 'Cập nhật thông tin tài thất bại!',
              showprogressIndicator: false,
            );
          }
        }
      }
      user.imageUrl = imageUri;
      final response = await _apiHandler.updateUserInformationByUserId(user);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        if (map['code'] == 200) {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Cập nhật thông tin tài khoản thành công!',
            showprogressIndicator: false,
          );
        } else {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Cập nhật thông tin tài khoản thất bại!',
            showprogressIndicator: false,
          );
        }
      }
    }
  }

  dispose() {
    _getImageFileController.close();
    _userController.close();
  }
}
