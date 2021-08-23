import 'package:baby_doctor/Models/Sample/InvoiceProcedureSample.dart';

class InvoiceProceduresResponse {
  final bool isSuccess;
  final String message;
  final InvoiceProcedureSample data;

  InvoiceProceduresResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory InvoiceProceduresResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceProceduresResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? InvoiceProcedureSample.fromJson(json['data']) : null);
  }
}

class InvoiceProceduresResponseList {
  final bool isSuccess;
  final String message;
  final List<InvoiceProcedureSample> data;

  InvoiceProceduresResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory InvoiceProceduresResponseList.fromJson(Map<String, dynamic> json) {
    List<InvoiceProcedureSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => InvoiceProcedureSample.fromJson(i)).toList();
    }
    return InvoiceProceduresResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
