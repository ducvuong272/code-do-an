import 'dart:async';
import 'dart:convert';
import 'package:do_an_tn/src/models/comment.dart';
import 'package:do_an_tn/src/services/api_handler.dart';

class CommentRepository {
  Comment comment;

  CommentRepository({this.comment});

  Future<String> postComment() async {
    ApiHandler apiHandler = ApiHandler();
    var response = await apiHandler.postComment(comment);
    Map<String, dynamic> map = json.decode(response);
    return map["code"].toString();
  }
}
