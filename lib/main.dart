import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/services/api_handle.dart';
import 'package:flutter/material.dart';
import 'package:do_an_tn/src/utils/export_screen.dart';

// void main() async {
//   ApiHandler apiHandleer = ApiHandler();
//   User _user = User(
//     userName: "morpheus",
//     job: "leader",
//   );
//   final response = await apiHandleer.postUser(_user);
//   print(response);
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}
