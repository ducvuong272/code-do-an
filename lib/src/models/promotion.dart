class Promotion {
  int idPromotion, idImage;
  String imageUrl;

  Promotion({this.idPromotion, this.imageUrl, this.idImage});

  Promotion.fromJson(Map<String, dynamic> json){
    idPromotion = json['Id_KhuyenMai'];
    idImage = json['Id_HinhAnhKhuyenMai'];
    imageUrl = json['TapTinKhuyenMai'];
  }
}