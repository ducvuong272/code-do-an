import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class LoginRepository {
  final User user;

  LoginRepository(this.user);

  ApiHandler _apiHandler = ApiHandler();

  Future<Map<String,dynamic>> callLoginApi() async {
    var response = await _apiHandler.checkLogin(user);
    Map<String, dynamic> map = jsonDecode(response);
    return map;
    // List<Map> mapList = [];
    // mapList.addAll([
    //   // jsonDecode(map['code'].toString()),
    //   // jsonDecode(map['data']),
    // ]);
    // print(mapList[0].toString());
    // return mapList;   
  }
}
