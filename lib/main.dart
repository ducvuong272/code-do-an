import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/repository/login_repository.dart';
import 'package:do_an_tn/src/screens/add_post_screen.dart';
import 'package:do_an_tn/src/screens/comment_screen.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/screens/post_detail_screen.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/utils/export_screen.dart';
import 'dart:convert';

// void main() async {
//   ApiHandler apiHandler = ApiHandler();
//   final _user = User(
//     username: "vuongdo272",
//     password: "vuong",
//   );
//   // var response = await apiHandler.checkLogin(_user);
//   var response = await apiHandler.getAllPosts();
//   var list =
//       (json.decode(response) as List).map((e) => new Post.fromJson(e)).toList();
//       print(list[0].imageUrl);

//   // Map<String, dynamic> map = jsonDecode(response);
//   // print(response);
//   // print(map['success'] == 'Đăng nhập thành công');
//   // var response = await apiHandler.getUser();
//   // Map<String, dynamic> map = jsonDecode(response);

//   // response.split('},').forEach((word) => print('},' + word));
//   // debugPrint(response.toString());

//   // User vuong = User.fromJson(jsonDecode(response));
//   // print(vuong.password + vuong.name);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIE Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
