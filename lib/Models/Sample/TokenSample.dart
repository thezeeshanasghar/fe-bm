class TokenSample {
  final bool isSuccess;
  final String message;
  final String jwtToken;
  final String refreshToken;
  final String createdDate;
  final String expiryDate;

  TokenSample({this.isSuccess, this.message, this.jwtToken, this.refreshToken, this.createdDate, this.expiryDate});

  factory TokenSample.fromJson(Map<String, dynamic> json) {
    return TokenSample(
      isSuccess: json['isSuccess'],
      message: json['message'],
      jwtToken: json['jwtToken'],
      refreshToken: json['refreshToken'],
      createdDate: json['createdDate'],
      expiryDate: json['expiryDate'],
    );
  }
}
