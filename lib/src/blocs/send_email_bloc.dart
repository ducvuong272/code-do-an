import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';

class EmailBloc {
  StreamController<String> _emailController = StreamController<String>();
  Stream<String> get emailStream => _emailController.stream;

  recoverPassword(BuildContext context, String email) async {
    bool isValidEmail = _isValidEmail(email);
    if (isValidEmail) {
      ApiHandler apiHandler = ApiHandler();
      CustomDialog customDialog = CustomDialog();
      customDialog.showCustomDialog(
        barrierDismissible: false,
        context: context,
        msg: 'Đang kiểm tra email...',
        showprogressIndicator: true,
      );
      final resposne = await apiHandler.sendEmailToGetPassword(email);
      Map<String, dynamic> map = json.decode(resposne.body);
      if (map['code'] == 200) {
        customDialog.hideCustomDialog(context);
        customDialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: 'Đã gửi thông tin khôi phục tài khoản đến email của bạn',
          showprogressIndicator: false,
        );
      } else {
        customDialog.hideCustomDialog(context);
        customDialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: map['success'].toString(),
          showprogressIndicator: false,
        );
      }
    }
  }

  bool _isValidEmail(String email) {
    if (email.trim().toString() == '') {
      _emailController.sink.addError('Email không được để trống');
      return false;
    }
    else if(!email.contains('@')){
      _emailController.sink.addError('Email sai định dạng');
      return false;
    }
    _emailController.sink.add('OK');
    return true;
  }

  dispose() {
    _emailController.close();
  }
}
