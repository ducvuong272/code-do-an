import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';

class SearchPostScreen extends StatefulWidget {
  @override
  SearchPostScreenState createState() => SearchPostScreenState();
}

class SearchPostScreenState extends State<SearchPostScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  TextEditingController _searchController = TextEditingController();
  PostBloc _postBloc = PostBloc();
  List<Post> _listPostData = [];
  List<Post> _listPostValue = [];
  List<String> _areaMap = [
    "Đà Nẵng",
    "TP Hồ Chí Minh",
    "Hà Nội",
    "Huế",
  ];
  int _areaIndex = 0;
  bool _showAreaPicker = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _postBloc.getAllPost(1);
    _postBloc.getAllPostStream.listen((onData) {
      setState(() {
        _listPostData = onData;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 150).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: StreamBuilder<Object>(
                stream: _postBloc.getPostSearchResultStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _listPostValue = snapshot.data;
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: _listPostValue.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: PostList(
                            address: _listPostValue[index].address,
                            postTitle: _listPostValue[index].postTitle,
                            imageUrl: _listPostValue[index].imageUrl,
                          ),
                        );
                      },
                    );
                  } else {
                    if (_listPostData.length > 0) {
                      return ListView.builder(
                        itemCount: _listPostData.length,
                        itemBuilder: (context, index) {
                          return PostList(
                            address: _listPostData[index].address,
                            postTitle: _listPostData[index].postTitle,
                            imageUrl: _listPostData[index].imageUrl,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                }),
          ),
          _buildSearchSection(),
          Positioned(
            top: 42,
            right: 5,
            child: Container(
              width: 150,
              height: _animation.value,
              child: Card(
                elevation: 6.0,
                child: ListView.builder(
                  itemCount: _areaMap.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _areaIndex = index;
                        });
                        _animationController.reverse();
                        _showAreaPicker = false;
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                _areaMap[index],
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            _areaIndex == index
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

  Widget _buildSearchSection() {
    return Container(
      color: Colors.red,
      height: 50,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _postBloc.instantSearchPost(
                          _listPostData,
                          value,
                        );
                      },
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tìm kiếm địa điểm',
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
                          '${_areaMap[_areaIndex]}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
