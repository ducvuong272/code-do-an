import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';

class SearchPostScreen extends StatefulWidget {
  @override
  SearchPostScreenState createState() => SearchPostScreenState();
}

class SearchPostScreenState extends State<SearchPostScreen> {
  TextEditingController _searchController = TextEditingController();
  PostBloc _postBloc = PostBloc();
  List<Post> _listPostData = [];
  List<Post> _listPostValue = [];

  @override
  void initState() {
    _postBloc.getAllPost();
    _postBloc.getAllPostStream.listen((onData) {
      setState(() {
        _listPostData = onData;
      });
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
                    // setState(() {
                    //   _isLoadingData = false;
                    // });
                    _listPostValue = snapshot.data;
                    return ListView.builder(
                      itemCount: _listPostValue.length,
                      itemBuilder: (context, index) {
                        return PostList(
                          address: _listPostValue[index].address,
                          postTitle: _listPostValue[index].postTitle,
                          imageUrl: _listPostValue[index].imageUrl,
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
          Container(
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
                              _postBloc.getPostSearchResult(
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
                        Row(
                          children: <Widget>[
                            Text(
                              'Đà Nẵng',
                              style: TextStyle(fontSize: 18),
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
        ],
      ),
    );
  }
}
