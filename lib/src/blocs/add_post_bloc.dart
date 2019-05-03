import 'dart:async';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/repository/post_repository.dart';
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

  Future<File> pickImageFromCamera() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    return imageFile;
  }

  Future<File> pickImageFromAlbum() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    return imageFile;
  }

  showOptionsToPickImage({
    Dialog dialog,
    BuildContext context,
    Function pickImageFromAlbum,
    Function pickImageFromCamera,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bạn muốn thêm hình ảnh từ đâu?'),
            actions: <Widget>[
              FlatButton(
                onPressed: pickImageFromAlbum,
                child: Text('Album ảnh'),
              ),
              FlatButton(
                onPressed: pickImageFromCamera,
                child: Text('Máy ảnh'),
              ),
            ],
          );
        });
  }

  addPost(Post post, BuildContext context, CustomDialog dialog) {
    PostRepository postRepository = PostRepository();
    
    dialog.showCustomDialog(
      msg: 'Đang tiến hành thêm địa điểm',
      barrierDismissible: false,
      context: context,
      showprogressIndicator: true,
    );
    Future future = postRepository.addPost(post);
    future.then((onValue) {
      print(onValue["success"]);
      if (onValue['code'] == 200) {
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

  dispose() {
    _openTimeController.close();
    _closeTimeController.close();
  }
}
