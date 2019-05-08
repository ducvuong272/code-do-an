class City{
  int cityId;
  String cityName;

  City({this.cityId, this.cityName});

  City.fromJson(Map<String, dynamic> json){
    cityId = json['Id_TinhThanhPho'];
    cityName = json['TenTinhThanhPho'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = Map<String, dynamic>();
    data['Id_TinhThanhPho'] = cityId;
    data['TenTinhThanhPho'] = cityName;
    return data;
  }
}