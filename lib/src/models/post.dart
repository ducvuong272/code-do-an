class Post {
  String postTitle, postDetail, imageUrl;
  int idPost;

  Post({
    this.idPost,
    this.imageUrl,
    this.postDetail,
    this.postTitle,
  });

  Post.fromJson(Map<String, dynamic> json) {
    postTitle = json["TenDiaDiem"];
    postDetail = json["DiaChi"];
    imageUrl = json["TapTinDiaDiem"];
  }
}
