import 'package:flutter/material.dart';

class AddPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text('Thêm địa điểm'),
          elevation: 0.0,
          centerTitle: true,
        ),
      ),
    );
  }
}
