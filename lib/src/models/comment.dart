class Comment {
  String commentContent, commentTime, firstName, lastName;
  double ratingPoint;
  int postID, userID, commentId;
  String userAvataImageUrl;
  List<String> commentImageUrlList;

  Comment({
    this.commentContent,
    this.ratingPoint,
    this.postID,
    this.userID,
    this.commentImageUrlList,
    this.lastName,
    this.firstName,
    this.commentId,
    this.commentTime,
    this.userAvataImageUrl,
  });

  // Chưa có get hình ảnh
  Comment.fromJson(Map<String, dynamic> json) {
    commentContent = json["NoiDung"];
    postID = json["Id_TaiKhoan"];
    userID = json["Id_DiaDiem"];
    ratingPoint = double.parse(json["DanhGia"]);
    commentId = json["Id_BinhLuan"];
    firstName = json["Ho"];
    lastName = json["Ten"];
    commentTime = json["ThoiGianBinhLuan"];
    userAvataImageUrl = json["TapTinDaiDien"];
    commentImageUrlList = json["TapTinBinhLuanS"];
  }

// Chưa có get hình ảnh
  Map<String, dynamic> toPostCommentJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["Id_TaiKhoan"] = userID;
    data["Id_DiaDiem"] = postID;
    data["NoiDung"] = commentContent;
    data["DiemDanhGia"] = ratingPoint.toString();
    data["TapTinBinhLuanS"] = commentImageUrlList;
    return data;
  }
}
