class AuthenticateLoginRequest {
  final String UserName;
  final String Password;

  AuthenticateLoginRequest({
    this.UserName,
    this.Password,
  });

  Map<String, dynamic> toJson() => {
        "UserName": UserName,
        "Password": Password,
      };
}

class AuthenticateRefreshRequest {
  final String jwtToken;
  final String refreshToken;

  AuthenticateRefreshRequest({
    this.jwtToken,
    this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
        "JwtToken": jwtToken,
        "RefreshToken": refreshToken,
      };
}
