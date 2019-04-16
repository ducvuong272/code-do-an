import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/repository/login_repository.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/screens/post_detail_screen.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/utils/export_screen.dart';
import 'dart:convert';

// void main() async {
//   ApiHandler apiHandler = ApiHandler();
//   final _user = User(
//     userName: "thainguyen",
//     password: "123456",
//   );
//   // var response = await apiHandler.checkLogin(_user);
//   // var response = await apiHandler.getAllPost();
//   // Map<String, dynamic> map = jsonDecode(response);
//   // print(response);
//   // print(map['success'] == 'Đăng nhập thành công');

//   LoginRepository _login = LoginRepository(_user);
//   var response = await _login.callLoginApi();
//   print(response);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
