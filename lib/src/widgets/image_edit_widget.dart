import 'dart:io';

import 'package:flutter/material.dart';

class ImageEditWidget extends StatelessWidget {
  final File imageFile;
  final Function() function;

  const ImageEditWidget({Key key, this.imageFile, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 300,
          width: 300,
          child: Image.file(
            imageFile,
            fit: BoxFit.fill,
          ),
        ),
        
      ],
    );
  }
}
