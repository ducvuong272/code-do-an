import 'package:do_an_tn/src/blocs/city_bloc.dart';
import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/city.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  CityBloc _cityBloc = CityBloc();
  List<Post> _listPostData = []; //Tất cả địa điểm theo thành phố
  List<Post> _listPostValue = []; //Tất cả điểm theo kết quả tìm kiếm
  Map<String, dynamic> _cityMap = {};
  int _cityIndex = 0;
  bool _showAreaPicker = false, _hasCityData = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cityBloc.getCityWithId();
    _cityBloc.cityStream.listen((onData) {
      List<City> cityList = onData;
      setState(() {
        _hasCityData = true;
        for (int i = 0; i < cityList.length; i++) {
          Map<String, dynamic> map = {cityList[i].cityName: cityList[i].cityId};
          _cityMap.addAll(map);
        }
        _postBloc.getAllPostByCityId(
          context,
          _cityMap.values.elementAt(_cityIndex),
          false,
        );
        _postBloc.getAllPostStream.listen((onData) {
          setState(() {
            _listPostData = onData;
          });
        });
      });
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
      body: !_hasCityData
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: StreamBuilder<Object>(
                      stream: _postBloc.getPostSearchResultStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) //Check nếu có sự kiện search
                        {
                          _listPostValue = snapshot.data;
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: _listPostValue.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: PostList(
                                  // address: _listPostValue[index].address,
                                  // postTitle: _listPostValue[index].postTitle,
                                  // imageUrl: _listPostValue[index].imageUrl,
                                  post: _listPostValue[index],
                                ),
                              );
                            },
                          );
                        } else {
                          //Nếu không có sự kiện search, show tất cả địa điểm theo thành phố
                          if (_listPostData.length > 0) {
                            return ListView.builder(
                              itemCount: _listPostData.length,
                              itemBuilder: (context, index) {
                                return PostList(
                                  // address: _listPostData[index].address,
                                  // postTitle: _listPostData[index].postTitle,
                                  // imageUrl: _listPostData[index].imageUrl,
                                  post: _listPostData[index],
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
                        itemCount: _cityMap.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              _animationController.reverse();
                              _showAreaPicker = false;
                              if (index != _cityIndex) {
                                setState(() {
                                  _cityIndex = index;
                                });
                                _postBloc.getAllPostByCityId(
                                  context,
                                  _cityMap.values.elementAt(_cityIndex),
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
                                      _cityMap.keys.elementAt(index),
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  _cityIndex == index
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
                          'Tại ${_cityMap.keys.elementAt(_cityIndex)}',
                          style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
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
