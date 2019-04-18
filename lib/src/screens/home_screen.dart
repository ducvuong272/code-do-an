import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/screens/post_detail_screen.dart';
import 'package:do_an_tn/src/widgets/home_screen_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({this.title, Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _imagePaths = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
  ];
  int _pageIndex = 0;
  ScrollController _scrollController;
  double androidBottomBarHeigh = 72.0;
  PostBloc _postBLoc = PostBloc();

  @override
  void initState() {
    _scrollController = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    )..addListener(() {
        print(_scrollController.offset ==
            _scrollController.position.maxScrollExtent);
      });
    _postBLoc.getAllPost();
    print('asd');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        color: Color(0xffb5bfce),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 150.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    margin: EdgeInsets.only(
                      top: 55.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Swiper(
                      autoplay: true,
                      itemCount: _imagePaths.length,
                      controller: SwiperController(),
                      index: _pageIndex,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            _imagePaths[index],
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                      onIndexChanged: (index) {
                        setState(() {
                          _pageIndex = index;
                        });
                      },
                    ),
                  ),
                  DotsIndicator(
                    dotShape: CircleBorder(
                      side: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    dotColor: Colors.white24,
                    numberOfDot: _imagePaths.length,
                    dotActiveColor: Colors.grey,
                    dotSpacing: EdgeInsets.all(3.0),
                    position: _pageIndex,
                  ),
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height -
                        205 -
                        androidBottomBarHeigh,
                    child: StreamBuilder<Object>(
                      stream: _postBLoc.getAllPostStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Post> _listPost = snapshot.data;
                          return GridView.count(
                            crossAxisCount: 2,
                            controller: _scrollController,
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            // childAspectRatio: 0.9,
                            children: List.generate(
                              _listPost.length,
                              (index) {
                                return GestureDetector(
                                  child: HomeScreenPost(
                                    postTitle: '${_listPost[index].postTitle}',
                                    postDetail:
                                        '${_listPost[index].postDetail}',
                                    postImage: Image.network(
                                      '${_listPost[index].imageUrl}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PostDetailScreen(
                                              title:
                                                  '${_listPost[index].postTitle}',
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              height: 50.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.black54,
                        ),
                        Text(
                          'Tìm kiếm món ăn, địa điểm...',
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Đà Nẵng',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
