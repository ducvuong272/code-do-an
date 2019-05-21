import 'comment.dart';

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
      postCategory,
      ratingPoint,
      country,
      exellent,
      nice,
      average,
      bad,
      openTimeStatus,
      numberOfPostWithSameUser,
      numberOfComments,
      numberOfUserSavedPost,
      numberOfImage;
  int postId, userId;
  List<Comment> commentList;

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
    this.postCategory,
    this.average,
    this.nice,
    this.exellent,
    this.ratingPoint,
    this.bad,
    this.commentList,
    this.numberOfComments,
    this.numberOfImage,
    this.numberOfUserSavedPost,
    this.numberOfPostWithSameUser,
    this.openTimeStatus,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postId = json["Id_DiaDiem"];
    postTitle = json["TenDiaDiem"];
    address = json["DiaChi"];
    imageUrl = json["TapTinDaiDien"];
    userId = json["Id_TaiKhoan"];
    ratingPoint = json["DiemDanhGia"];
  }

  Post.fromPostDetailJson(Map<String, dynamic> json) {
    postId = json["Id_DiaDiem"];
    postTitle = json["TenDiaDiem"];
    imageUrl = json["TapTinDaiDien"];
    userId = json["Id_TaiKhoan"];
    openTime = json['GioMoCua'];
    closeTime = json['GioDongCua'];
    address = json['DiaChi'];
    ratingPoint = json['DanhGia'];
    highestPrice = json['GiaCaoNhat'];
    lowestPrice = json['GiaThapNhat'];
    postCategory = json['TenLoaiHinhDiaDiem'];
    city = json['TenTinhThanhPho'];
    district = json['TenQuanHuyen'];
    exellent = json['TuyetVoi'];
    nice = json['Kha'];
    postDetail = json['MoTa'];
    average = json['TrungBinh'];
    bad = json['Kem'];
    openTimeStatus = json['TrangThaiMoCua'];
    numberOfPostWithSameUser = json['DiaDiemChungHeThong'];
    numberOfComments = json['SoLuongBinhLuan'];
    numberOfUserSavedPost = json['SoLuongLuuLai'];
    numberOfImage = json['SoLuongHinhAnh'];
    if (json['ListBinhLuan'] != null) {
      var commentListMap = (json['ListBinhLuan'] as List)
          .map((f) => Comment.fromJson(f))
          .toList();
      commentList = commentListMap;
    } else {
      commentList = [];
    }
  }

  Post.fromSavedPostJson(Map<String, dynamic> json) {
    postId = json["Id_DiaDiem"];
    postTitle = json["TenDiaDiem"];
    imageUrl = json["TapTinDaiDien"];
    userId = json["Id_TaiKhoan"];
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
    data["TenLoaiHinhDiaDiem"] = postCategory;
    data["TenQuanHuyen"] = district;
    data["SoDienThoai"] = phoneNumber;
    data["GioMoCua"] = openTime;
    data["GioDongCua"] = closeTime;
    data["GiaCaoNhat"] = highestPrice;
    data["GiaThapNhat"] = lowestPrice;
    data["Id_TaiKhoan"] = userId;
    data["TapTinDaiDien"] = imageUrl;
    return data;
  }
}
