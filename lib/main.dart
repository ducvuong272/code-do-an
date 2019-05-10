import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/repository/comment_repository.dart';
import 'package:do_an_tn/src/screens/home_dashboard.dart';
import 'package:do_an_tn/src/screens/test_screen.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:flutter/material.dart';

// void main() async {
//   Comment comment = Comment(
//     commentContent: "Test api",
//     userID: 55,
//     postID: 10,
//     ratingPoint: 7.0,
//   );
//   CommentRepository commentRepository = CommentRepository(comment: comment);
//   String response = await commentRepository.postComment();
//   print(response);

//   // response.split('},').forEach((word) => print('},' + word));
//   // debugPrint(response.toString());
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
