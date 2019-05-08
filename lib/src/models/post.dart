class Post {
  String postTitle,
      postDetail,
      imageUrl,
      city,
      district,
      phoneNumber,
      address,
      openTime,
      closeTime,
      highestPrice,
      lowestPrice,
      postCategories,
      ratingPoint,
      country;
  int postId, userId;

  Post({
    this.postId,
    this.imageUrl,
    this.postDetail,
    this.postTitle,
    this.lowestPrice,
    this.highestPrice,
    this.closeTime,
    this.openTime,
    this.phoneNumber,
    this.district,
    this.address,
    this.city,
    this.userId,
    this.country,
    this.postCategories,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postId = json["Id_DiaDiem"];
    postTitle = json["TenDiaDiem"];
    address = json["DiaChi"];
    imageUrl = json["TapTinDaiDien"];
    userId = json["Id_TaiKhoan"];
  }

  Post.fromSavedPostJson(Map<String, dynamic> json){
    postId = json["Id_DiaDiem"];
    postTitle = json["TenDiaDiem"];
    imageUrl = json["TapTinDaiDien"];
    userId = int.parse(json["Id_TaiKhoan"]);
    ratingPoint = json["DanhGiaDiaDiem"].toString();
    address = json["DiaChi"];
  }

  Map<String, dynamic> toAddPostJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["TenDiaDiem"] = postTitle;
    data["DiaChi"] = address;
    data["MoTa"] = postDetail;
    data["ThanhPho"] = city;
    data["TenQuocGia"] = country;
    data["TenTinhThanhPho"] = city;
    data["TenLoaiHinhDiaDiem"] = postCategories;
    data["TenQuanHuyen"] = district;
    data["SoDienThoai"] = phoneNumber;
    data["GioMoCua"] = openTime;
    data["GioDongCua"] = closeTime;
    data["GiaCaoNhat"] = highestPrice;
    data["GiaThapNhat"] = lowestPrice;
    data["Id_TaiKhoan"] = userId;
    return data;
  }
}
