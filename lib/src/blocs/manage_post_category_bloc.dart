import 'dart:convert';

import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

import 'add_post_bloc.dart';

class ManagePostCategoryBloc {
  ApiHandler _apiHandler = ApiHandler();

  Future<Null> addPostCategory(
    String postCategory,
    BuildContext context,
    AddPostBloc addPostBloc,
  ) async {
    CustomDialog dialog = CustomDialog();
    if (postCategory == null || postCategory.trim() == '') {
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Tên loại hình địa điểm không được để trống !',
        showprogressIndicator: false,
      );
    } else {
      dialog.showCustomDialog(
        barrierDismissible: false,
        context: context,
        msg: 'Đang xử lý...',
        showprogressIndicator: true,
      );
      var response = await _apiHandler.addPostCategory(postCategory);
      if (response.statusCode == 200) {
        Map<String, dynamic> resultMap = json.decode(response.body);
        if (resultMap["code"] == 200) {
          await addPostBloc.getAllPostCategory().then((onValue) {
            dialog.hideCustomDialog(context);
            dialog.showCustomDialog(
              barrierDismissible: true,
              context: context,
              msg: 'Thêm loại hình địa điểm thành công!',
              showprogressIndicator: false,
            );
          });
        } else {
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Thêm loại hình địa điểm thất bại!',
            showprogressIndicator: false,
          );
        }
      } else {
        dialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: 'Thêm loại hình địa điểm thất bại!',
          showprogressIndicator: false,
        );
      }
    }
  }

  Future<Null> deletePostCategoryById(
    int postCategoryId,
    BuildContext context,
    AddPostBloc addPostBloc,
  ) async {
    CustomDialog dialog = CustomDialog();
    dialog.showCustomDialog(
      barrierDismissible: false,
      context: context,
      msg: 'Đang xử lý...',
      showprogressIndicator: true,
    );
    var response = await _apiHandler.deletePostCategoryById(postCategoryId);
    if (response.statusCode == 200) {
      Map<String, dynamic> resultMap = json.decode(response.body);
      if (resultMap["code"] == 200) {
        await addPostBloc.getAllPostCategory().then((onValue) {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Xóa loại hình địa điểm thành công!',
            showprogressIndicator: false,
          );
        });
      } else {
        dialog.hideCustomDialog(context);
        dialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: 'Xóa loại hình địa điểm thất bại!',
          showprogressIndicator: false,
        );
      }
    } else {
      dialog.hideCustomDialog(context);
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Xóa loại hình địa điểm thất bại!',
        showprogressIndicator: false,
      );
    }
  }
}
