class User {
  String username, password, imageUrl, email, firstName, lastName;
  int userId, roleId;

  User({
    this.password,
    this.username,
    this.email,
    this.roleId,
    this.imageUrl,
    this.userId,
    this.firstName,
    this.lastName,
  });

  User.fromJson(Map<String, dynamic> json) {
    username = json['TenTaiKhoan'];
    password = json['MatKhau'];
    email = json['Email'];
    imageUrl = json['TapTinDaiDien'];
    roleId = json['Id_VaiTro'];
    userId = json['Id_TaiKhoan'];
    firstName = json['Ho'];
    lastName = json['Ten'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenTaiKhoan'] = this.username;
    data['MatKhau'] = this.password;
    data['Email'] = this.email;
    data['TapTinTaiKhoan'] = this.imageUrl;
    data['Id_VaiTro'] = this.roleId;
    data['Id_TaiKhoan'] = this.userId;
    data['Ho'] = this.firstName;
    data['Ten'] = this.lastName;
    return data;
  }

  Map<String, dynamic> toRegisterJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TenTaiKhoan'] = this.username;
    data['MatKhau'] = this.password;
    data['Ho'] = this.firstName;
    data['Ten'] = this.lastName;
    data['Email'] = this.email;
    return data;
  }

  Map<String, dynamic> toUpdateUserInfoJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Ho'] = firstName;
    data['Ten'] = lastName;
    data['Email'] = email;
    data['TapTinDaiDien'] = imageUrl;
    return data;
  }
}
