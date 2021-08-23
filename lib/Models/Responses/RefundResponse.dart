import 'package:baby_doctor/Models/Sample/RefundSample.dart';

class RefundResponse {
  final bool isSuccess;
  final String message;
  final RefundSample data;

  RefundResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory RefundResponse.fromJson(Map<String, dynamic> json) {
    return RefundResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? RefundSample.fromJson(json['data']) : null);
  }
}

class RefundResponseList {
  final bool isSuccess;
  final String message;
  final List<RefundSample> data;

  RefundResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory RefundResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<RefundSample> dataList = list.map((i) => RefundSample.fromJson(i)).toList();
    return RefundResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
