import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'add_post_bloc.dart';

class ManagePostCategoryBloc {
  StreamController<List<Map<String, dynamic>>> _postCategoryController =
      StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get getPostCategoryResultStream =>
      _postCategoryController.stream;
  ApiHandler _apiHandler = ApiHandler();

  instantSearchPostCategory(List<Map<String, dynamic>> listMap, String value) {
    List<Map<String, dynamic>> listMapResult = listMap
        .where((data) => data['TenLoaiHinhDiaDiem']
            .toString()
            .toLowerCase()
            .contains(value.toLowerCase()))
        .toList();
    _postCategoryController.sink.add(listMapResult);
  }

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
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Bạn muỗn xóa loại địa điểm này?'),
              title: Text('Xác nhận xóa loại địa điểm'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Xác nhận'),
                  onPressed: () async {
                    CustomDialog dialog = CustomDialog();
                    dialog.showCustomDialog(
                      barrierDismissible: false,
                      context: context,
                      msg: 'Đang xử lý...',
                      showprogressIndicator: true,
                    );
                    var response = await _apiHandler
                        .deletePostCategoryById(postCategoryId);
                    if (response.statusCode == 200) {
                      Map<String, dynamic> resultMap =
                          json.decode(response.body);
                      if (resultMap["code"] == 200) {
                        await addPostBloc.getAllPostCategory().then((onValue) {
                          dialog.hideCustomDialog(context);
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
                      dialog.hideCustomDialog(context);
                      dialog.showCustomDialog(
                        barrierDismissible: true,
                        context: context,
                        msg: 'Xóa loại hình địa điểm thất bại!',
                        showprogressIndicator: false,
                      );
                    }
                  },
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Hủy'),
                ),
              ],
            ));
  }

  Future<Null> updatePostCategory(
    int postCategoryId,
    String updateName,
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
    final response =
        await _apiHandler.updatePostCategory(postCategoryId, updateName);
    if (response.statusCode == 200) {
      Map<String, dynamic> resultMap = json.decode(response.body);
      if (resultMap["code"] == 200) {
        addPostBloc.getAllPostCategory().then((onValue) {
          dialog.hideCustomDialog(context);
          dialog.showCustomDialog(
            barrierDismissible: true,
            context: context,
            msg: 'Sửa loại địa điểm thành công!',
            showprogressIndicator: false,
          );
        });
      } else {
        dialog.hideCustomDialog(context);
        dialog.showCustomDialog(
          barrierDismissible: true,
          context: context,
          msg: 'Sửa loại địa điểm thất bại !',
          showprogressIndicator: false,
        );
      }
    } else {
      dialog.hideCustomDialog(context);
      dialog.showCustomDialog(
        barrierDismissible: true,
        context: context,
        msg: 'Sửa loại địa điểm thất bại !',
        showprogressIndicator: false,
      );
    }
  }

  dispose() {
    _postCategoryController.close();
  }
}
