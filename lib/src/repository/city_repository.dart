import 'dart:convert';

import 'package:do_an_tn/src/models/city.dart';
import 'package:do_an_tn/src/services/api_handler.dart';

class CityRepository {
  ApiHandler _apiHandler = ApiHandler();

  Future<List<City>> fetchCityWithId() async {
    final response = await _apiHandler.fetchCityByWithId();
    List<City> cityList = [];
    Map<String, dynamic> map = json.decode(response.body);
    if (map['code'] == 200) {
      print(map['data']);
      cityList = (map['data'] as List)
          .map(
            (f) => City.fromJson(f),
          )
          .toList();
      print(cityList.length);
    }
    return cityList;
  }
}
