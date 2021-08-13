class AuthenticateLoginRequest {
  final String UserName;
  final String Password;

  AuthenticateLoginRequest(
    this.UserName,
    this.Password,
  );

  Map<String, dynamic> toJson() => {
        "UserName": UserName,
        "Password": Password,
      };
}

class AuthenticateRefreshRequest {
  final String JwtToken;
  final String RefreshToken;

  AuthenticateRefreshRequest(
    this.JwtToken,
    this.RefreshToken,
  );

  Map<String, dynamic> toJson() => {
        "UserName": JwtToken,
        "Password": RefreshToken,
      };
}
