import 'package:do_an_tn/src/blocs/add_post_bloc.dart';
import 'package:do_an_tn/src/blocs/manage_post_category_bloc.dart';
import 'package:flutter/material.dart';

class AddPostCategoryScreen extends StatefulWidget {
  final AddPostBloc addPostBloc;

  const AddPostCategoryScreen({Key key, this.addPostBloc}) : super(key: key);

  AddPostCategoryScreenState createState() => AddPostCategoryScreenState();
}

class AddPostCategoryScreenState extends State<AddPostCategoryScreen> {
  TextEditingController _postCateforyController = TextEditingController();
  ManagePostCategoryBloc _bloc = ManagePostCategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text('Quản loại hình địa điểm'),
        ),
      ),
      body: Align(
        alignment: FractionalOffset(0.5, 0.5),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Thêm loại hình địa điểm',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  color: Colors.black,
                  height: 2,
                  width: MediaQuery.of(context).size.width - 50,
                ),
                Text(
                  'Tên loại hình địa điểm',
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(border: Border.all(width: 1.5)),
                  child: TextField(
                    controller: _postCateforyController,
                    decoration: InputDecoration(
                      labelText: 'Nhập tên loại hình địa điểm',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    onPressed: () {
                      _bloc.addPostCategory(
                        _postCateforyController.text,
                        context,
                        widget.addPostBloc,
                      );
                    },
                    elevation: 6.0,
                    child: Text(
                      'Thêm',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
