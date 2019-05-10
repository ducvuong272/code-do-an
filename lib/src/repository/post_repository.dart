import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/promotion.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'dart:convert';

class PostRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<Post>> getAllPostsByCityId(int cityId) async {
    final response = await _apiHandler.getAllPostsByCityId(cityId);
    var listPosts = (json.decode(response)['data'] as List)
        .map((json) => new Post.fromJson(json))
        .toList();
    return listPosts;
  }

  Future<List<Promotion>> getPromotionImageUrls() async {
    final response = await _apiHandler.getPromotionImages();
    List<Promotion> listPromotion = [];
    if (response.statusCode == 200) {
      var map = (json.decode(response.body) as List)
          .map((f) => Promotion.fromJson(f))
          .toList();
      listPromotion = map;
    }
    return listPromotion;
  }

  Future<Map<String, dynamic>> addPost(Post post) async {
    final response = await _apiHandler.addPost(post);
    var map = json.decode(response);
    return map;
  }

  Future<List<Post>> getSavedPost(int userId) async {
    final response = await _apiHandler.getSavedPost(userId);
    List<Post> postList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      if (map['code'] == 200) {
        var mapToList = (map['data'] as List)
            .map((f) => Post.fromSavedPostJson(f))
            .toList();
        print(mapToList.length);
        postList = mapToList;
      }
    }
    return postList;
  }

  Future<List<Post>> getAllPostOfUser(int userId) async {
    final response = await _apiHandler.getAllPostOfUser(userId);
    List<Post> postList = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      if (map['code'] == 200) {
        var mapToList = (map['data'] as List)
            .map((f) => Post.fromSavedPostJson(f))
            .toList();
        print(mapToList.length);
        postList = mapToList;
      }
    }
    return postList;
  }

  Future<List<Map<String, dynamic>>> getAllPostCategory() async {
    List<Map<String, dynamic>> categoryListMap = [];
    final response = await _apiHandler.getAllPostCategory();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      if (map['code'] == 200) {
        List<dynamic> listCategory = map['data'];
        for (int i = 0; i < listCategory.length; i++) {
          print(listCategory[i]['TenLoaiHinhDiaDiem']);
          Map<String, dynamic> mapFromDataList = {};
          mapFromDataList.putIfAbsent('Id', () => listCategory[i]['Id_Cha']);
          mapFromDataList.putIfAbsent('TenLoaiHinhDiaDiem',
              () => listCategory[i]['TenLoaiHinhDiaDiem']);
          categoryListMap.add(mapFromDataList);
        }
      }
    }
    print(categoryListMap);
    return categoryListMap;
  }

  Future<List<Map<String, dynamic>>> getAllCity() async {
    List<Map<String, dynamic>> cityListMap = [];
    final response = await _apiHandler.getAllCity();
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      if (map['code'] == 200) {
        List<dynamic> listCity = map['data'];
        for (int i = 0; i < listCity.length; i++) {
          Map<String, dynamic> mapFromDataList = {};
          mapFromDataList.putIfAbsent(
              'Id', () => listCity[i]['Id_TinhThanhPho']);
          mapFromDataList.putIfAbsent(
              'TenTinhThanhPho', () => listCity[i]['TenTinhThanhPho']);
          cityListMap.add(mapFromDataList);
        }
      }
    }
    return cityListMap;
  }

  Future<List<String>> getDistrictByCityId(int cityId) async{
    List<String> listDistrict = [];
    ApiHandler apiHandler = ApiHandler();
    final response = await apiHandler.getDistrictByCityId(cityId);
    if(response.statusCode == 200){
      Map<String, dynamic> map = json.decode(response.body);
      if(map['code'] == 200){
        List<dynamic> listDisctrictFromMap = map['data'];
        for(int i = 0; i<listDisctrictFromMap.length;i++){
          listDistrict.add(listDisctrictFromMap.elementAt(i)['TenQuanHuyen']);
        }
      }
    }
    return listDistrict;
  }
}
