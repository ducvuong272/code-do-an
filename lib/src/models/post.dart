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
      lowestPrice,postCategories;
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
    this.postCategories,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postTitle = json["TenDiaDiem"];
    address = json["DiaChi"];
    imageUrl = json["TapTinDaiDien"];
  }

  Map<String, dynamic> toAddPostJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["TenDiaDiem"] = postTitle;
    data["DiaChi"] = address;
    data["MoTa"] = postDetail;
    // data["ThanhPho"] = city;
    data["TenLoaiHinhDiaDiem"] = postCategories;
    data["TenQuanHuyen"] = district;
    data["SoDienThoai"] = phoneNumber;
    data["GioMoCua"] = openTime;
    data["GioDongCua"] = closeTime;
    data["GiaCaoNhat"] = int.parse(highestPrice);
    data["GiaThapNhat"] = int.parse(lowestPrice);
    data["Id_TaiKhoan"] = userId;
    return data;
  }
}
