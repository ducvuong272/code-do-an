import 'package:flutter/material.dart';
import 'package:do_an_tn/src/utils/export_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DashboardScreen extends StatefulWidget {
  final String username;

  const DashboardScreen({Key key, this.username}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  SwiperController _pageController = new SwiperController();
  int _index = 0;

  @override
  void dispose() {
    _pageController.dispose();
    print('home dashboard disposed');
    super.dispose();
  }

  _navigatorToPage(int page) {
    _pageController.move(page);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetList = [
      HomeScreen(),
      UserSavedScreen(),
      PostsOfUserScreen(
        username: widget.username,
      ),
      UserAccountScreen(
        username: widget.username,
      ),
    ];
    return Scaffold(
      body: Swiper(
        itemBuilder: (context, index) =>
            _index == index ? _widgetList[_index] : _widgetList[index],
        itemCount: 4,
        controller: _pageController,
        index: _index,
        loop: false,
        onIndexChanged: (index) {
          setState(() {
            _index = index < _widgetList.length ? index : _index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        iconSize: 25,
        onTap: (int index) {
          _navigatorToPage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _index == 0 ? Colors.purple : Colors.black38,
            ),
            title: Text('Trang chủ'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: _index == 1 ? Colors.purple : Colors.black38,
            ),
            title: Text('Đã Lưu'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notification_important,
              color: _index == 2 ? Colors.purple : Colors.black38,
            ),
            title: Text('Địa điểm của tôi'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _index == 3 ? Colors.purple : Colors.black38,
            ),
            title: Text('Tài khoản'),
          ),
        ],
      ),
    );
  }
}
