// import 'dart:async';

// import 'package:do_an_tn/src/models/city.dart';
// import 'package:do_an_tn/src/repository/city_repository.dart';

// class CityBloc{
//   StreamController<List<City>> _cityController = StreamController<List<City>>.broadcast();
//   Stream<List<City>> get cityStream => _cityController.stream;

//   Future<Null>getCityWithId() async{
//     CityRepository cityRepository = CityRepository();
//     await cityRepository.fetchCityWithId().then((onValue){
//       _cityController.sink.add(onValue);
//     });
//   }

//   dispose(){
//     _cityController.close();
//   }
// }