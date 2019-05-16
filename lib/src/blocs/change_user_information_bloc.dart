import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateUserInfoBloc {
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

  updateUserInfor(User user, BuildContext context) async {
    CustomDialog dialog = CustomDialog();
    dialog.showCustomDialog(
      barrierDismissible: false,
      context: context,
      msg: 'Đang xử lý...',
      showprogressIndicator: true,
    );
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
          msg: 'Cập nhật thông tin tài thất bại!',
          showprogressIndicator: false,
        );
      }
    }
  }

  dispose() {
    _getImageFileController.close();
  }
}
