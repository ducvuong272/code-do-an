import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/blocs/save_post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/comment_screen.dart';
import 'package:do_an_tn/src/screens/login_dashboard.dart';
import 'package:do_an_tn/src/widgets/comment_section.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final User user;
  final int postId;
  final String postTitle;

  const PostDetailScreen({
    Key key,
    this.user,
    this.postId,
    this.postTitle,
  }) : super(key: key);

  @override
  PostDetailScreenState createState() => PostDetailScreenState();
}

class PostDetailScreenState extends State<PostDetailScreen> {
  PostBloc _postBloc = PostBloc();
  Post post = Post();

  @override
  void initState() {
    print(widget.postId);
    _postBloc.getPostDetailByPostId(widget.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          title: Text(
            widget.postTitle != null ? widget.postTitle : '',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: StreamBuilder<Object>(
          stream: _postBloc.getPostDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              post = snapshot.data;
              return Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xffc0c1c4),
                    child: Scrollbar(
                      child: ListView(
                        controller: _scrollController,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                child: post.imageUrl == null ||
                                        post.imageUrl.trim() == ''
                                    ? Container()
                                    : Image.network(
                                        post.imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                                child: Text(
                                  post.postTitle,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            '${post.numberOfPostWithSameUser} Địa điểm cùng hệ thống',
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          _postStatus(
                                              int.parse(post.numberOfComments),
                                              'Bình luận'),
                                          _postStatus(
                                              int.parse(post.numberOfImage),
                                              'Hình ảnh'),
                                          _postStatus(
                                              int.parse(
                                                  post.numberOfUserSavedPost),
                                              'Lưu lại'),
                                          CircleAvatar(
                                            backgroundColor: Color(0xff187a1d),
                                            radius: 18,
                                            child: Text(
                                              post.ratingPoint != null
                                                  ? post.ratingPoint
                                                  : 'N/A',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              post.openTimeStatus == '1'
                                                  ? 'ĐANG MỞ CỬA'
                                                  : 'CHƯA MỞ CỬA',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                    post.openTimeStatus == '1'
                                                        ? Color(0xff04cc0e)
                                                        : Colors.red,
                                              ),
                                            ),
                                            Text(
                                              '${post.openTime} - ${post.closeTime}',
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
                                  top: 5,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      _postInfor(
                                        Icons.location_on,
                                        '${post.address}',
                                      ),
                                      _postInfor(
                                        Icons.fastfood,
                                        '${post.postCategory} - ${post.city}',
                                      ),
                                      _postInfor(
                                        Icons.attach_money,
                                        '${post.lowestPrice} đồng - ${post.highestPrice} đồng',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: GestureDetector(
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: GestureDetector(
                                  onTap: () =>
                                      print(MediaQuery.of(context).size.height),
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
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              '${post.numberOfComments} Bình luận',
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
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  post.ratingPoint == null
                                                      ? 'N/A'
                                                      : '${post.ratingPoint}',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                    color: post
                                                                .ratingPoint ==
                                                            null
                                                        ? Colors.black
                                                        : double.parse(post
                                                                    .ratingPoint) >=
                                                                8.0
                                                            ? Colors.blue
                                                            : double.parse(post
                                                                        .ratingPoint) >=
                                                                    6.5
                                                                ? Colors.green
                                                                : double.parse(post
                                                                            .ratingPoint) >=
                                                                        6.5
                                                                    ? Colors
                                                                        .black
                                                                    : double.parse(post.ratingPoint) >=
                                                                            5.0
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .red,
                                                  ),
                                                ),
                                                Text(
                                                  post.ratingPoint == null
                                                      ? 'Chưa có đánh giá'
                                                      : double.parse(post
                                                                  .ratingPoint) >=
                                                              8.0
                                                          ? 'Tuyệt vời'
                                                          : double.parse(post
                                                                      .ratingPoint) >=
                                                                  6.5
                                                              ? 'Khá tốt'
                                                              : double.parse(post
                                                                          .ratingPoint) >=
                                                                      5.0
                                                                  ? 'Trung bình'
                                                                  : 'Kém',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w800,
                                                    color: post
                                                                .ratingPoint ==
                                                            null
                                                        ? Colors.black
                                                        : double.parse(post
                                                                    .ratingPoint) >=
                                                                8.0
                                                            ? Colors.blue
                                                            : double.parse(post
                                                                        .ratingPoint) >=
                                                                    6.5
                                                                ? Colors.green
                                                                : double.parse(post
                                                                            .ratingPoint) >=
                                                                        6.5
                                                                    ? Colors
                                                                        .black
                                                                    : double.parse(post.ratingPoint) >=
                                                                            5.0
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .red,
                                                  ),
                                                ),
                                              ],
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        _emotionSection(
                                          'assets/images/exellent.png',
                                          'Tuyệt vời',
                                          '${post.exellent}',
                                          Colors.blue,
                                        ),
                                        _emotionSection(
                                          'assets/images/good.png',
                                          'Khá tốt',
                                          '${post.nice}',
                                          Colors.green,
                                        ),
                                        _emotionSection(
                                          'assets/images/ok.png',
                                          'Trung bình',
                                          '${post.average}',
                                          Colors.black,
                                        ),
                                        _emotionSection(
                                          'assets/images/bad.png',
                                          'Kém',
                                          '${post.bad}',
                                          Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              post.commentList.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Container(
                                        height: 50,
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                                'Địa điểm này chưa có bình luận'),
                                          ],
                                        ),
                                      ),
                                    )
                                  : CommentSection(
                                      postTitle: post.postTitle,
                                      commentList: post.commentList,
                                      scrollController: _scrollController,
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _constantSection(context),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
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
        top: 10,
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
          ),
        ],
      ),
    );
  }

  Widget _postStatus(int data, String title) {
    return Column(
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
            fontSize: 15,
            color: Color(0xff6e7077),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _constantSection(BuildContext context) {
    return Container(
      color: Color(0xff484b4f).withOpacity(0.85),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _constantElements(
            Icons.photo_size_select_large,
            'Hình ảnh',
            () {
              print(DateTime.now().toLocal());
            },
          ),
          _constantElements(
            Icons.chat_bubble_outline,
            'Bình luận',
            () {
              if (widget.user == null) {
                _askForLogin();
              } else {
                print(widget.user.userId);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                          post: post,
                          user: widget.user,
                        ),
                  ),
                );
              }
            },
          ),
          _constantElements(
            Icons.done_outline,
            'Lưu lại',
            () {
              if (widget.user == null) {
                _askForLogin();
              } else {
                SavePostBloc savePostBloc = SavePostBloc();
                print('user id: ${widget.user.userId}');
                print('post id: ${post.postId}');
                savePostBloc.savePost(
                  context: context,
                  postId: post.postId,
                  userId: widget.user.userId,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  _askForLogin() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Vui lòng đăng nhập để tiếp tục'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginDashboard()));
                  },
                  child: Text('Đăng nhập'),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Bỏ qua'),
                ),
              ],
            ));
  }

  Widget _constantElements(IconData iconData, String text, Function function) {
    return FlatButton(
      onPressed: () {
        function();
      },
      splashColor: Color(0xff6d6f72),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.white,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
