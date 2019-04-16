import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostsOfUserScreen extends StatefulWidget {
  final String username;

  const PostsOfUserScreen({Key key, this.username}) : super(key: key);

  @override
  _PostsOfUserScreenState createState() => _PostsOfUserScreenState();
}

class _PostsOfUserScreenState extends State<PostsOfUserScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    String _username = widget.username == null ? '' : widget.username;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          titleSpacing: 12,
          centerTitle: true,
          title: Text('Địa điểm của tôi'),
        ),
      ),
      body: Container(
        color: Color(0xffc0cde0),
        child: Center(
          child: _username == ''
              ? LoginNotifyWidget(
                  context: context,
                )
              : Text(
                  'Bạn hiện chưa có địa điểm nào',
                  style: TextStyle(fontSize: 20),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
