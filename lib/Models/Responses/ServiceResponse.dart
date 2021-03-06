import 'package:baby_doctor/Models/Sample/ServiceSample.dart';

class ServiceResponse {
  final bool isSuccess;
  final String message;
  final ServiceSample data;

  ServiceResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? ServiceSample.fromJson(json['data']) : null);
  }
}

class ServiceResponseList {
  final bool isSuccess;
  final String message;
  final List<ServiceSample> data;

  ServiceResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ServiceResponseList.fromJson(Map<String, dynamic> json) {
    List<ServiceSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => ServiceSample.fromJson(i)).toList();
    }
    return ServiceResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
