import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final String title;

  const PostDetailScreen({Key key, this.title}) : super(key: key);

  @override
  PostDetailScreenState createState() => PostDetailScreenState();
}

class PostDetailScreenState extends State<PostDetailScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(vsync: this, length: 5);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          title: Text(
            widget.title != null ? widget.title : '',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Container(
              child: TabBar(
                indicatorWeight: 0.1,
                controller: _tabController,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      'Tải ảnh',
                      strutStyle: StrutStyle(fontSize: 12),
                    ),
                  ),
                  Tab(
                    child: Text('Check-in'),
                  ),
                  Tab(
                    child: Text(
                      'Bình luận',
                      strutStyle: StrutStyle(),
                    ),
                  ),
                  Tab(
                    child: Text('Lưu lại'),
                  ),
                  Tab(
                    child: Text('Chia sẻ'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xffc0c1c4),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: widget.title,
                  child: Container(
                    child: Image.asset(
                      'assets/images/1.png',
                      fit: BoxFit.fill,
                    ),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            child: Icon(
                              Icons.store_mall_directory,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.blue,
                            radius: 18,
                          ),
                          Container(
                            child: Text(
                              '3 Địa điểm cùng hệ thống',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            _postStatus(52, 'Bình luận'),
                            _postStatus(124, 'Hình ảnh'),
                            _postStatus(15, 'Check-in'),
                            _postStatus(22, 'Lưu lại'),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundColor: Color(0xff187a1d),
                                child: Text(
                                  '6.9',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ĐANG MỞ CỬA',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff04cc0e),
                                ),
                              ),
                              Text(
                                '8:00 - 21:00',
                                style: TextStyle(fontSize: 16),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        _postInfor(
                          Icons.location_on,
                          '14 Nguyễn Chí Thanh, Hải Châu, Đà Nẵng',
                        ),
                        _postInfor(
                          Icons.fastfood,
                          'Quán ăn - Đà Nẵng',
                        ),
                        _postInfor(
                          Icons.attach_money,
                          '20000 đồng - 50000 đồng',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _postInfor(
                          Icons.restaurant_menu,
                          'Xem thực đơn',
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Center(
                      child: Text(
                        'Xem tất cả thông tin',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '52 Bình luận',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              padding: EdgeInsets.only(left: 5),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: 5,
                                top: 15,
                                bottom: 15,
                              ),
                              child: Text(
                                '6.9 Trung bình',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 3,
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _emotionSection(
                            'assets/images/exellent.png',
                            'Tuyệt vời',
                            '5',
                            Colors.blue,
                          ),
                          _emotionSection(
                            'assets/images/good.png',
                            'Khá tốt',
                            '5',
                            Colors.green,
                          ),
                          _emotionSection(
                            'assets/images/ok.png',
                            'Trung bình',
                            '5',
                            Colors.black,
                          ),
                          _emotionSection(
                            'assets/images/bad.png',
                            'Kém',
                            '5',
                            Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _emotionSection(
    String imagePath,
    String feeling,
    String number,
    Color color,
  ) {
    return Column(
      children: <Widget>[
        Container(
          height: 30,
          child: Image.asset(imagePath),
        ),
        Text(
          feeling,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: color,
          ),
        ),
        Text(
          number,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _postInfor(IconData iconData, String infor) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 10,
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: 5,
              right: 10,
            ),
            child: CircleAvatar(
              child: Icon(
                iconData,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
              radius: 12,
            ),
          ),
          Text(
            infor,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _postStatus(int data, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
      child: Column(
        children: <Widget>[
          Text(
            '$data',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Text(
            '$title',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xff6e7077),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
