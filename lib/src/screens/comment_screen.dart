import 'dart:io';
import 'package:do_an_tn/src/blocs/comment_bloc.dart';
import 'package:do_an_tn/src/blocs/post_bloc.dart';
import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/image_edit_widget.dart';
import 'package:flutter/material.dart';
// import 'package:multi_image_picker/multi_image_picker.dart';

class CommentScreen extends StatefulWidget {
  final User user;
  final Post post;
  final PostBloc postBloc;

  const CommentScreen({Key key, this.user, this.post, this.postBloc})
      : super(key: key);

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  int _locationRating = 5,
      _priceRating = 5,
      _qualityRating = 5,
      _serviceRating = 5,
      _viewRating = 5;
  double _averageRatingPoint = 5.0;
  TextEditingController _commentContentController = TextEditingController();
  // List<Asset> _images = List<Asset>();
  List<File> _listImage = [];
  ScrollController _scrollController = ScrollController();
  CommentBloc _commentBloc = CommentBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          title: Text('Viết bình luận'),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                // _listImage.forEach((f) =>
                //     Future.delayed(Duration(seconds: 2), () => print(f.path)));
                //     print(_listImage);
                Comment comment = Comment(
                  commentContent: _commentContentController.text,
                  postID: widget.post.postId,
                  userID: widget.user.userId,
                  ratingPoint: _averageRatingPoint,
                );
                _commentBloc.postComment(
                  context,
                  comment,
                  widget.postBloc, 
                  widget.post.postId,
                );
              },
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Text(
                    'Đăng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            Container(
              color: Color(0xffdce0e5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Đánh giá địa điểm',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset(0.2, 0.5),
                          widthFactor: 1.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 20.0,
                            child: Text(
                              '$_averageRatingPoint',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildRatingSection(),
                  Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: FractionalOffset(0, 0.5),
                      child: Text(
                        'Bình luận',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: StreamBuilder<Object>(
                        stream: _commentBloc.imageFilesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && _listImage.length > 0) {
                            _listImage = snapshot.data;
                            print(_listImage.length);
                            return GridView.count(
                              shrinkWrap: true,
                              controller: _scrollController,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              crossAxisCount: 2,
                              children:
                                  List.generate(_listImage.length, (index) {
                                return Stack(
                                  children: <Widget>[
                                    ImageEditWidget(
                                      imageFile: _listImage[index],
                                    ),
                                    Positioned(
                                      top: 2,
                                      right: 2,
                                      child: GestureDetector(
                                        onTap: () => _removeImage(index),
                                        child: CircleAvatar(
                                          maxRadius: 15,
                                          backgroundColor: Colors.white24,
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            );
                          }
                          return Container();
                        }),
                  ),
                  Container(
                    color: Colors.white,
                    child: TextField(
                      maxLines: 30,
                      autocorrect: false,
                      controller: _commentContentController,
                      decoration: InputDecoration(
                        labelText: 'Thêm bình luận',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _commentBloc.addImageToList(_listImage);
        },
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }

  void _removeImage(int index) {
    print(_listImage.length);
    print(index);
    _commentBloc.removeImage(_listImage, index);
  }

  Widget _buildRatingSection() {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: _ratingComponents(
            _locationRating,
            'Vị trí',
            Slider(
              onChanged: (value) {
                setState(() {
                  _locationRating = value.toInt();
                });
                _onRatingValuesChanged();
              },
              value: _locationRating.toDouble(),
              min: 0.0,
              max: 10.0,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: _ratingComponents(
            _priceRating,
            'Giá cả',
            Slider(
              onChanged: (value) {
                setState(() {
                  _priceRating = value.toInt();
                });
                _onRatingValuesChanged();
              },
              value: _priceRating.toDouble(),
              min: 0.0,
              max: 10.0,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: _ratingComponents(
            _qualityRating,
            'Chất lượng',
            Slider(
              onChanged: (value) {
                setState(() {
                  _qualityRating = value.toInt();
                });
                _onRatingValuesChanged();
              },
              value: _qualityRating.toDouble(),
              min: 0.0,
              max: 10.0,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: _ratingComponents(
            _serviceRating,
            'Dịch vụ',
            Slider(
              onChanged: (value) {
                setState(() {
                  _serviceRating = value.toInt();
                });
                _onRatingValuesChanged();
              },
              value: _serviceRating.toDouble(),
              min: 0.0,
              max: 10.0,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: _ratingComponents(
            _viewRating,
            'Không gian',
            Slider(
              onChanged: (value) {
                setState(() {
                  _viewRating = value.toInt();
                });
                _onRatingValuesChanged();
              },
              value: _viewRating.toDouble(),
              min: 0.0,
              max: 10.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _ratingComponents(int ratingPoint, String text, Slider slider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '$ratingPoint',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: slider,
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          width: 120,
          child: Align(
            alignment: FractionalOffset(0, 0),
            child: Text(
              '$text',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  _onRatingValuesChanged() {
    setState(() {
      _averageRatingPoint = (_locationRating +
              _priceRating +
              _qualityRating +
              _serviceRating +
              _viewRating) /
          5.toDouble();
    });
  }
}
