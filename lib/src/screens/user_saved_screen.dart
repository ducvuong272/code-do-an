import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserSavedScreen extends StatefulWidget {
  final User user;

  const UserSavedScreen({Key key, this.user}) : super(key: key);

  @override
  _UserSavedScreenState createState() => _UserSavedScreenState();
}

class _UserSavedScreenState extends State<UserSavedScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    User _user = widget.user;
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    TabController _tabController = TabController(length: 4, vsync: this);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            titleSpacing: 12,
            centerTitle: true,
            title: Text('Địa điểm đã lưu'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Container(
                height: 40.0,
                color: Colors.white,
                child: TabBar(
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.blue,
                  indicatorWeight: 4.0,
                  isScrollable: false,
                  tabs: [
                    Tab(
                      child: Text(
                        'Tất cả',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Địa điểm',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Bài viết',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Hình ảnh',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              color: Color(0xffc0cde0),
              child: _user != null
                  ? Container()
                  : LoginNotifyWidget(
                      context: context,
                    ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                  child: _user != null
                      ? Container()
                      : LoginNotifyWidget(context: context)),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                  child: _user != null
                      ? Container()
                      : LoginNotifyWidget(context: context)),
            ),
            Container(
              color: Colors.yellow,
              child: Center(
                  child: _user != null
                      ? Container()
                      : LoginNotifyWidget(context: context)),
            ),
          ],
        ),
      ),
    );
  }
}
