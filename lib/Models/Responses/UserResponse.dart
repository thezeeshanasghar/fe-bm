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
        isSuccess: json['isSuccess'], message: json['message'], data: UserSample.fromJson(json['data']));
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
    var list = json['data'] as List;
    List<UserSample> dataList = list.map((i) => UserSample.fromJson(i)).toList();
    return UserResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
