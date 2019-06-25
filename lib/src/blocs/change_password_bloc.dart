import 'dart:convert';

import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

class ChangePasswordBloc {
  ApiHandler _apiHandler = ApiHandler();
  changePasswordByUserId(
    int userId,
    String oldPassword,
    String newPassword,
    String confirmPassword,
    BuildContext context,
  ) async {
    CustomDialog dialog = CustomDialog();
    if (oldPassword.trim() == '' ||
        newPassword.trim() == '' ||
        confirmPassword.trim() == '') {
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Vui lòng nhập đầy đủ thông tin',
        showprogressIndicator: false,
      );
    } else if (newPassword != confirmPassword) {
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Xác nhận mật khẩu không chính xác',
        showprogressIndicator: false,
      );
    } else {
      dialog.showCustomDialog(
        barrierDismissible: false,
        context: context,
        msg: 'Đang xử lý',
        showprogressIndicator: true,
      );
      final response = await _apiHandler.changePasswordById(
        userId,
        oldPassword,
        newPassword,
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);
        if (map["code"] == 200) {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Thay đổi mật khẩu thành công',
            showprogressIndicator: false,
          );
        } else if (map["code"] == 400) {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Mật khẩu cũ không chính xác',
            showprogressIndicator: false,
          );
        } else {
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Đổi mật khẩu thất bại',
            showprogressIndicator: false,
          );
        }
      }
    }
  }
}
