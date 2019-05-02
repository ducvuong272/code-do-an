class Comment {
  String commentContent;
  double ratingPoint;
  int postID, userID;
  List<String> imageUrl;

  Comment({
    this.commentContent,
    this.ratingPoint,
    this.postID,
    this.userID,
    this.imageUrl,
  });

  // Chưa có get hình ảnh
  Comment.fromJson(Map<String, dynamic> json) {
    commentContent = json["NoiDung"];
    postID = json["Id_TaiKhoan"];
    userID = json["Id_DiaDiem"];
    ratingPoint = double.parse(json["DiemDanhGia"]);
  }

// Chưa có get hình ảnh
  Map<String, dynamic> toPostCommentJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["Id_TaiKhoan"] = userID;
    data["Id_DiaDiem"] = postID;
    data["NoiDung"] = commentContent;
    data["DiemDanhGia"] = ratingPoint.toString();
    return data;
  }
}
