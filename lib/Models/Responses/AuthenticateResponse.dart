class AuthenticateResponse {
  final bool isSuccess;
  final String message;
  final AuthenticateResponseData data;
  final AuthenticateResponseToken token;

  AuthenticateResponse({
    this.isSuccess,
    this.message,
    this.token,
    this.data,
  });

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        token: json['token'],
        data: json['data']);
  }
}

class AuthenticateResponseData {
  final int id;
  final int userId;
  final String userName;
  final String password;

  AuthenticateResponseData({
    this.id,
    this.userId,
    this.userName,
    this.password,
  });

  factory AuthenticateResponseData.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponseData(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      password: json['password'],
    );
  }
}

class AuthenticateResponseToken {
  final bool isSuccess;
  final String message;
  final String jwtToken;
  final String refreshToken;
  final String createdDate;
  final String expiryDate;

  AuthenticateResponseToken(
      {this.isSuccess,
      this.message,
      this.jwtToken,
      this.refreshToken,
      this.createdDate,
      this.expiryDate});

  factory AuthenticateResponseToken.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponseToken(
      isSuccess: json['isSuccess'],
      message: json['message'],
      jwtToken: json['jwtToken'],
      refreshToken: json['refreshToken'],
      createdDate: json['createdDate'],
      expiryDate: json['expiryDate'],
    );
  }
}
