import 'package:baby_doctor/Models/Sample/LoginSample.dart';
import 'package:baby_doctor/Models/Sample/TokenSample.dart';

class AuthenticateResponse {
  final bool isSuccess;
  final String message;
  final LoginSample data;
  final TokenSample token;

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
      token: json['token'] != null ? TokenSample.fromJson(json['token']) : null,
      data: json['data'] != null ? LoginSample.fromJson(json['data']) : null,
    );
  }
}
