import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/add_post_screen.dart';
import 'package:do_an_tn/src/widgets/login_notify_button.dart';
import 'package:do_an_tn/src/widgets/post_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostsOfUserScreen extends StatefulWidget {
  final User user;

  const PostsOfUserScreen({Key key, this.user}) : super(key: key);

  @override
  _PostsOfUserScreenState createState() => _PostsOfUserScreenState();
}

class _PostsOfUserScreenState extends State<PostsOfUserScreen> {
  PostBloc _postBloc;
  bool _hasData = false;

  @override
  void initState() {
    _postBloc = PostBloc();
    if (widget.user != null) {
      print('user: ' + widget.user.userId.toString());
      _postBloc.getAllPostOfUser(widget.user.userId).whenComplete(() {
        setState(() {
          _hasData = true;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
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
          title: Text('Địa điểm của tôi'),
        ),
      ),
      body: Container(
        color: Color(0xffc0cde0),
        child: Center(
          child: widget.user == null
              ? LoginNotifyWidget(
                  context: context,
                )
              : _hasData == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : StreamBuilder<Object>(
                      stream: _postBloc.getAllPostOfUserStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Post> listPost = snapshot.data;
                          print('length: ' + listPost.length.toString());
                          return ListView.builder(
                            itemCount: listPost.length,
                            itemBuilder: (context, index) {
                              return PostList(
                                post: listPost[index],
                              );
                            },
                          );
                        }
                        return Center(
                          child: Text('Không có địa điểm'),
                        );
                      },
                    ),
        ),
      ),
      floatingActionButton: widget.user != null
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddPostScreen(
                          user: widget.user,
                        ),
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
