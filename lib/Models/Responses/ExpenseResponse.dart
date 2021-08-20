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
        isSuccess: json['isSuccess'], message: json['message'], data: ExpenseSample.fromJson(json['data']));
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
    var list = json['data'] as List;
    List<ExpenseSample> dataList = list.map((i) => ExpenseSample.fromJson(i)).toList();
    return ExpenseResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
