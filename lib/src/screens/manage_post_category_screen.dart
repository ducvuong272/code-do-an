import 'package:do_an_tn/src/blocs/add_post_bloc.dart';
import 'package:do_an_tn/src/widgets/management_list.dart';
import 'package:flutter/material.dart';

import 'add_post_category_screen.dart';

class ManagePostCategoryScreen extends StatefulWidget {
  @override
  ManagePostCategoryScreenState createState() =>
      ManagePostCategoryScreenState();
}

class ManagePostCategoryScreenState extends State<ManagePostCategoryScreen> {
  AddPostBloc _addPostBloc = AddPostBloc();
  ScrollController _listViewController = ScrollController();

  @override
  void initState() {
    _addPostBloc.getAllPostCategory();
    super.initState();
  }

  @override
  void dispose() {
    _addPostBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Quản lý loại hình địa điểm'),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: StreamBuilder<Object>(
                    stream: _addPostBloc.getAllPostCategoryStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Map<String, dynamic>> categoryMapList =
                            snapshot.data;
                        return ListView.builder(
                          controller: _listViewController,
                          shrinkWrap: true,
                          itemCount: categoryMapList.length,
                          itemBuilder: (context, index) {
                            return ManagementList(
                              map: categoryMapList[index],
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPostCategoryScreen(
                      addPostBloc: _addPostBloc,
                    ),
              ),
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
