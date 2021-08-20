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
        isSuccess: json['isSuccess'], message: json['message'], data: ReceiptSample.fromJson(json['data']));
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
    var list = json['data'] as List;
    List<ReceiptSample> dataList = list.map((i) => ReceiptSample.fromJson(i)).toList();
    return ReceiptResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
