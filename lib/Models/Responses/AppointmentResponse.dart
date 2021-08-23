import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';

class AppointmentResponse {
  final bool isSuccess;
  final String message;
  final AppointmentSample data;

  AppointmentResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? AppointmentSample.fromJson(json['data']) : null);
  }
}

class AppointmentResponseList {
  final bool isSuccess;
  final String message;
  final List<AppointmentSample> data;

  AppointmentResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory AppointmentResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<AppointmentSample> dataList = list.map((i) => AppointmentSample.fromJson(i)).toList();
    return AppointmentResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
