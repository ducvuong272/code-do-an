import 'dart:async';
import 'package:flutter/material.dart';

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

  dispose() {
    _openTimeController.close();
    _closeTimeController.close();
  }
}
