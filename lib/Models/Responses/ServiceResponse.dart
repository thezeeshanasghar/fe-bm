import 'package:baby_doctor/Models/Sample/ServiceSample.dart';

class ServiceResponse {
  final bool isSuccess;
  final String message;
  final List<ServiceSample> data;

  ServiceResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceSample> dataList =
        list.map((i) => ServiceSample.fromJson(i)).toList();
    return ServiceResponse(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}