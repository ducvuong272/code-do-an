class User {
  String username, password, imageUrl, email, name;
  int userId, roleId;

  User({
    this.password,
    this.username,
    this.email,
    this.roleId,
    this.imageUrl,
    this.userId,
    this.name,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['TenTaiKhoan'];
    password = json['MatKhau'];
    email = json['Email'];
    imageUrl = json['TapTinTaiKhoan'];
    roleId = json['Id_VaiTro'];
    userId = json['Id_TaiKhoan'];
    name = json['HoTen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenTaiKhoan'] = this.username;
    data['MatKhau'] = this.password;
    data['Email'] = this.email;
    data['TapTinTaiKhoan'] = this.imageUrl;
    data['Id_VaiTro'] = this.roleId;
    data['Id_TaiKhoan'] = this.userId;
    data['HoTen'] = this.name;
    return data;
  }

  Map<String, dynamic> toRegisterJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenTaiKhoan'] = this.username;
    data['MatKhau'] = this.password;
    data['HoTen'] = this.name;
    data['Email'] = this.email;
    return data;
  }
}
