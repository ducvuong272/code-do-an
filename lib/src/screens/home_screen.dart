import 'package:do_an_tn/src/blocs/add_post_bloc.dart';
import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/post_detail_screen.dart';
import 'package:do_an_tn/src/screens/search_post_screen.dart';
import 'package:do_an_tn/src/services/check_network_connectivity.dart';
import 'package:do_an_tn/src/widgets/home_screen_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final User user;

  HomeScreen({this.title, Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> _cityMap = [];
  int _pageIndex = 0, _cityMapIndex = 0;
  ScrollController _scrollController;
  List<String> _imageUrls = [];
  double androidBottomBarHeigh = 72.0;
  PostBloc _postBLoc;
  AddPostBloc _addPostBloc;
  bool _hasInternetConnection = false,
      _finishLoading = false,
      _showAreaPicker = false;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // _scrollController = ScrollController(
    //   initialScrollOffset: 0.0,
    //   keepScrollOffset: true,
    // )..addListener(() {
    //     print(_scrollController.offset ==
    //         _scrollController.position.maxScrollExtent);
    //   });
    _postBLoc = PostBloc();
    _addPostBloc = AddPostBloc();
    var _isNetworkConnected =
        NetworkConnection().checkNetworkConnectivity(context);
    _isNetworkConnected.then((onValue) {
      if (onValue == true) {
        setState(() {
          _hasInternetConnection = true;
        });
        _addPostBloc.getAllCity();
        _addPostBloc.getAllCityStream.listen((onData) async {
          _cityMap = onData;
          await _postBLoc.getPromotionImages().whenComplete(() {
            setState(() {
              _finishLoading = true;
            });
          });
          await _postBLoc.getAllPostByCityId(
            context,
            _cityMap.elementAt(_cityMapIndex)['Id'],
            false,
          );
        });
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _animation = Tween<double>(begin: 0, end: 150).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: !_finishLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 55),
                            height: 170,
                            color: Colors.white,
                            child: StreamBuilder<Object>(
                                stream: _postBLoc.promotionImageStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    _imageUrls = snapshot.data;
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          height: 150.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(50.0),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0,
                                          ),
                                          child: Swiper(
                                            autoplay: true,
                                            itemCount: _imageUrls.length,
                                            controller: SwiperController(),
                                            index: _pageIndex,
                                            itemBuilder: (context, index) {
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.network(
                                                  _imageUrls[index],
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
                                        _imageUrls.length > 0
                                            ? Container(
                                                height: 20,
                                                child: DotsIndicator(
                                                  dotShape: CircleBorder(
                                                    side: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  dotColor: Colors.white24,
                                                  numberOfDot:
                                                      _imageUrls.length,
                                                  dotActiveColor: Colors.grey,
                                                  dotSpacing:
                                                      EdgeInsets.all(3.0),
                                                  position: _pageIndex,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 220),
                            child: _hasInternetConnection == false
                                ? Container()
                                : StreamBuilder<Object>(
                                    stream: _postBLoc.getAllPostStream,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        List<Post> listPost = snapshot.data;
                                        return GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          controller: _scrollController,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          // childAspectRatio: 0.9,
                                          children: List.generate(
                                            listPost.length,
                                            (index) {
                                              return InkWell(
                                                child: Container(
                                                  child: HomeScreenPost(
                                                    postTitle:
                                                        '${listPost[index].postTitle}',
                                                    address:
                                                        '${listPost[index].address}',
                                                    postImage:
                                                        '${listPost[index].imageUrl}',
                                                  ),
                                                ),
                                                onTap: () {
                                                  print(listPost[index].postId);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostDetailScreen(
                                                            post:
                                                                listPost[index],
                                                            user: widget.user,
                                                          ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                        Expanded(
                                                  child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SearchPostScreen(
                                      cityMap: _cityMap,
                                    ),
                                  ),
                                ),
                            child: Container(color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                  ),
                                  Text(
                                    'Tìm kiếm địa điểm...',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showAreaPicker
                                ? _animationController.reverse()
                                : _animationController.forward();
                            _showAreaPicker = !_showAreaPicker;
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                _cityMap.elementAt(_cityMapIndex)['TenTinhThanhPho'],
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 42,
                  right: 5,
                  child: Container(
                    width: 150,
                    height: _animation.value,
                    child: Card(
                      elevation: 6.0,
                      child: ListView.builder(
                        itemCount: _cityMap.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _animationController.reverse();
                              _showAreaPicker = false;
                              if (index != _cityMapIndex) {
                                setState(() {
                                  _cityMapIndex = index;
                                });
                                _postBLoc.getAllPostByCityId(
                                  context,
                                  _cityMap.elementAt(_cityMapIndex)['Id'],
                                  true,
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      _cityMap.elementAt(index)['TenTinhThanhPho'],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  _cityMapIndex == index
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.red,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _postBLoc.dispose();
    _addPostBloc.dispose();
    super.dispose();
  }
}
