import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:do_an_tn/src/utils/export_model.dart';
import 'package:do_an_tn/src/constants.dart';

class ApiHandler {
  Future<String> checkLogin(User user) async {
    final apiUrl = kUserUrl;
    final response = await http.post(
      apiUrl,
      body: json.encode(user.toJson()),
      headers: kApiHeader,
    );
    print(json.encode(user));
    return response.body;
  }
}
