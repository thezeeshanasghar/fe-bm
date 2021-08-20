class LoginRequest {
  int id;
  int userId;
  String userName;
  String password;

  LoginRequest({this.id, this.userId, this.userName, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    return data;
  }
}
