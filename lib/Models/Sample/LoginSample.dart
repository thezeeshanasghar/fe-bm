class LoginSample {
  final int id;
  final int userId;

  final String userName;
  final String password;

  LoginSample({
    this.id,
    this.userId,
    this.userName,
    this.password,
  });

  factory LoginSample.fromJson(Map<String, dynamic> json) {
    return LoginSample(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      password: json['password'],
    );
  }
}
