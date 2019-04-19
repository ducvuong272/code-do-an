import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/add_post_screen.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostsOfUserScreen extends StatefulWidget {
  final User user;

  const PostsOfUserScreen({Key key, this.user}) : super(key: key);

  @override
  _PostsOfUserScreenState createState() => _PostsOfUserScreenState();
}

class _PostsOfUserScreenState extends State<PostsOfUserScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
          child: widget.user == null
              ? LoginNotifyWidget(
                  context: context,
                )
              : Text(
                  'Bạn hiện chưa có địa điểm nào',
                  style: TextStyle(fontSize: 20),
                ),
        ),
      ),
      floatingActionButton: widget.user != null
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPost(),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
