import 'package:baby_doctor/Models/Sample/UserSample.dart';

class UserResponse {
  final bool isSuccess;
  final String message;
  final UserSample data;

  UserResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? UserSample.fromJson(json['data']) : null);
  }
}

class UserResponseList {
  final bool isSuccess;
  final String message;
  final List<UserSample> data;

  UserResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory UserResponseList.fromJson(Map<String, dynamic> json) {
    List<UserSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => UserSample.fromJson(i)).toList();
    }
    return UserResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
