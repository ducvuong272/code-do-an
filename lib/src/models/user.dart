class User {
  String userName;
  String job;

  User({this.job, this.userName});

  User.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.userName;
    data['job'] = this.job;
    return data;
  }
}
