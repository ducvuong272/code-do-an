import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    TabController _tabController = TabController(length: 3, vsync: this);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.red,
            titleSpacing: 12,
            centerTitle: true,
            title: Text('Thông báo'),
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
                        'Dịch vụ',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Của tôi',
                        strutStyle: StrutStyle(fontSize: 30),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Tin mới',
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
              child: LoginNotifyWidget(),
            ),
            Container(
              color: Colors.green,
              child: Center(child: LoginNotifyWidget(context: context)),
            ),
            Container(
              color: Colors.blue,
              child: Center(child: LoginNotifyWidget(context: context)),
            ),
            Container(
              color: Colors.yellow,
              child: Center(child: LoginNotifyWidget(context: context)),
            ),
          ],
        ),
      ),
    );
  }
}
