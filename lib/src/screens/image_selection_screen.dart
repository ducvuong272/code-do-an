import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageSelectionScreen extends StatefulWidget {
  @override
  ImageSelectionScreenState createState() => ImageSelectionScreenState();
}

class ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<Image> _imageList = [];
  List<File> _imageUrlList = [];
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text('Lựa chọn hình ảnh'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                // print('object');
                _getImage();
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.green,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: _imageFile != null
          ? Image.file(_imageFile)
          : Text('data'),
              )
            ],
          ),
      ),
    );
  }

  _getImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    print(_imageFile);
    setState(() {});
    // image.then(
    //   (onValue) {
    //     if (onValue != null) {
    //       _imageUrlList.add(onValue);
    //     }
    //   },
    // );
  }
}
