import 'package:flutter/material.dart';

class HomeScreenPost extends StatefulWidget {
  final String postTitle, address;
  final String postImage;

  const HomeScreenPost({
    Key key,
    this.postTitle,
    this.address,
    this.postImage,
  }) : super(key: key);

  @override
  HomeScreenPostState createState() => HomeScreenPostState();
}

class HomeScreenPostState extends State<HomeScreenPost> {
  Image _image;
  bool _imageLoading = true;

  @override
  void initState() {
    _image = Image.network(
      widget.postImage,
      fit: BoxFit.fill,
    );
    _image.image.resolve(ImageConfiguration()).addListener((_, __) {
      if (mounted) {
        setState(() {
          _imageLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(5),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Colors.white,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                child: Container(
                  height:
                      (MediaQuery.of(context).size.height - 205 - 72.0) / 2 -
                          100 *
                              731.4285714285714 /
                              MediaQuery.of(context).size.height,
                  width: 400,
                  child: _imageLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _image,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.postTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  widget.address,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
