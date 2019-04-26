import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserSavedScreen extends StatefulWidget {
  final User user;

  const UserSavedScreen({Key key, this.user}) : super(key: key);

  @override
  _UserSavedScreenState createState() => _UserSavedScreenState();
}

class _UserSavedScreenState extends State<UserSavedScreen> {
  @override
  Widget build(BuildContext context) {
    User _user = widget.user;
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
          title: Text('Địa điểm đã lưu'),
        ),
      ),
      body: Container(
        color: Color(0xffc0cde0),
        child: _user != null
            ?
            // Center(
            //     child: Text(
            //       'Chưa có địa điểm nào được lưu',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   )
            ListView.builder(
                itemCount: 19,
                itemBuilder: (context, index) {
                  return PostList();
                },
              )
            : LoginNotifyWidget(
                context: context,
              ),
      ),
    );
  }
}
