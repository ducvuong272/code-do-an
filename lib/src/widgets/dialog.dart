import 'package:flutter/material.dart';

class CustomDialog {
  showCustomDialog({
    BuildContext context,
    String msg,
    bool barrierDismissible,
    bool showprogressIndicator,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showprogressIndicator
                      ? CircularProgressIndicator()
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(msg),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  hideCustomDialog(BuildContext context) {
    Navigator.of(context).pop(CustomDialog);
  }
}
