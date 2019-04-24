import 'package:do_an_tn/src/blocs/comment_bloc.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  int _locationRating = 5,
      _priceRating = 5,
      _qualityRating = 5,
      _serviceRating = 5,
      _viewRating = 5;
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
            Container(
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
            )
          ],
        ),
      ),
      body: ListView(
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
                            '6.0',
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
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 5.0,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/1.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/1.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: TextField(
                    maxLines: 30,
                    autocorrect: false,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      children: <Widget>[
        StreamBuilder<Object>(
            stream: _commentBloc.locationRatingStream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: _ratingComponents(
                  snapshot.hasData ? snapshot.data : _locationRating,
                  'Vị trí',
                  _commentBloc.locationRatingStream,
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _commentBloc.priceRatingStream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: _ratingComponents(
                  _priceRating,
                  'Giá cả',
                  _commentBloc.priceRatingStream,
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _commentBloc.qualityRatingStream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: _ratingComponents(
                  _qualityRating,
                  'Chất lượng',
                  _commentBloc.qualityRatingStream,
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _commentBloc.serviceRatingStream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: _ratingComponents(
                  _serviceRating,
                  'Dịch vụ',
                  _commentBloc.serviceRatingStream,
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _commentBloc.viewRatingStream,
            builder: (context, snapshot) {
              return Container(
                color: Colors.white,
                child: _ratingComponents(
                  _viewRating,
                  'Không gian',
                  _commentBloc.viewRatingStream,
                ),
              );
            }),
      ],
    );
  }

  Widget _ratingComponents(int ratingPoint, String text, Stream stream) {
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
          child: Slider(
            value: ratingPoint.toDouble(),
            onChanged: (value) {
              _commentBloc.onSliderChange(stream, value.toInt());
            },
            min: 0.0,
            max: 10.0,
          ),
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
}
