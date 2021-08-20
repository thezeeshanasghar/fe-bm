import 'package:baby_doctor/Models/Sample/LoginSample.dart';

class LoginResponse {
  final bool isSuccess;
  final String message;
  final LoginSample data;

  LoginResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        isSuccess: json['isSuccess'], message: json['message'], data: LoginSample.fromJson(json['data']));
  }
}

class LoginResponseList {
  final bool isSuccess;
  final String message;
  final List<LoginSample> data;

  LoginResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory LoginResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LoginSample> dataList = list.map((i) => LoginSample.fromJson(i)).toList();
    return LoginResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
