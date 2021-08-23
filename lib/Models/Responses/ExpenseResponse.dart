import 'package:baby_doctor/Models/Sample/ExpenseSample.dart';

class ExpenseResponse {
  final bool isSuccess;
  final String message;
  final ExpenseSample data;

  ExpenseResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ExpenseResponse.fromJson(Map<String, dynamic> json) {
    return ExpenseResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? ExpenseSample.fromJson(json['data']) : null);
  }
}

class ExpenseResponseList {
  final bool isSuccess;
  final String message;
  final List<ExpenseSample> data;

  ExpenseResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ExpenseResponseList.fromJson(Map<String, dynamic> json) {
    List<ExpenseSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => ExpenseSample.fromJson(i)).toList();
    }
    return ExpenseResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
