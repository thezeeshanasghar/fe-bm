import 'package:baby_doctor/Models/Sample/ReceiptSample.dart';

class ReceiptResponse {
  final bool isSuccess;
  final String message;
  final ReceiptSample data;

  ReceiptResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? ReceiptSample.fromJson(json['data']) : null);
  }
}

class ReceiptResponseList {
  final bool isSuccess;
  final String message;
  final List<ReceiptSample> data;

  ReceiptResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ReceiptResponseList.fromJson(Map<String, dynamic> json) {
    List<ReceiptSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => ReceiptSample.fromJson(i)).toList();
    }
    return ReceiptResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
