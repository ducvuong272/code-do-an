import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/enum.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserSavedScreen extends StatefulWidget {
  final User user;

  const UserSavedScreen({Key key, this.user}) : super(key: key);

  @override
  _UserSavedScreenState createState() => _UserSavedScreenState();
}

class _UserSavedScreenState extends State<UserSavedScreen> {
  PostBloc _postBloc = PostBloc();

  @override
  void initState() {
    if (widget.user != null) {
      print(widget.user.userId);
      _postBloc.getSavedPostList(widget.user.userId);
    }
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _postBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          titleSpacing: 12,
          centerTitle: true,
          title: Text('Địa điểm đã lưu'),
        ),
      ),
      body: Container(
        color: Color(0xffc0cde0),
        child: widget.user == null
            ? LoginNotifyWidget(context: context)
            : StreamBuilder<Object>(
                stream: _postBloc.getSavedPostListStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Post> postList = snapshot.data;
                    print(postList.length);
                    return postList.length > 0 == false
                        ? Center(
                            child: Text(
                              'Chưa có địa điểm nào được lưu',
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                        : ListView.builder(
                            itemCount: postList.length,
                            itemBuilder: (context, index) {
                              return postList.length > 0
                                  ? PostList(
                                      post: postList[index],
                                      user: widget.user,
                                      typeOfPostList:
                                          TypeOfPostList.savedPostList,
                                      deletePostfunction: () {
                                        showDialog<AlertDialog>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Xác nhận xóa địa điểm'),
                                                content: Text(
                                                    'Bạn muốn bỏ lưu địa điểm này ?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      _postBloc
                                                          .deleteSavedPostByPostId(
                                                        context: context,
                                                        postId: postList[index]
                                                            .postId,
                                                        userId:
                                                            widget.user.userId,
                                                      );
                                                      postList.removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: Text('Xóa địa điểm'),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Không'),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text('Bạn chưa lưu địa điểm nào'),
                                    );
                            },
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
      ),
    );
  }
}
