import 'dart:convert';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

class SavePostBloc {
  savePost({BuildContext context, int postId, int userId}) async {
    CustomDialog().showCustomDialog(
      barrierDismissible: false,
      context: context,
      msg: 'Đang tiến hành lưu địa điểm',
      showprogressIndicator: true,
    );
    ApiHandler _apiHandler = ApiHandler();
    Map<String, int> savePostMap = {
      "Id_TaiKhoan": userId,
      "Id_DiaDiem": postId,
    };
    var response = await _apiHandler.savePost(savePostMap);
    Map<String, dynamic> map = json.decode(response.body);
    print(map);
    if (map['code'] == 200) {
      Navigator.of(context).pop();
      CustomDialog().showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Lưu địa điểm thành công!',
        showprogressIndicator: false,
      );
    } else if (map['code'] == 204) {
      Navigator.pop(context);
      CustomDialog().showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Bạn đã lưu địa điểm này rồi',
        showprogressIndicator: false,
      );
    }
  }
}
