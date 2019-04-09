class User {
  String userName;
  String password;

  User({this.password, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['TenTaiKhoan'];
    password = json['MatKhau'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenTaiKhoan'] = this.userName;
    data['MatKhau'] = this.password;
    return data;
  }
}
