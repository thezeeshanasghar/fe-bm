import 'package:flutter/foundation.dart';
import 'Employee.dart';

class Nurse {
  final bool isSuccess;
  final String message;
  final List<NurseData> data;

  Nurse({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Nurse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NurseData> dataList =
    list.map((i) => NurseData.fromJson(i)).toList();
    return Nurse(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class NurseData {
  final int id;
  final int DutyDuration;
  final int SharePercentage;
  final int Salary;
  final EmployeeData employee;

  NurseData(
      {this.id,
        @required this.DutyDuration,
        @required this.SharePercentage,
        @required this.Salary,
        @required this.employee});

  factory NurseData.fromJson(Map<String, dynamic> json) {
    return NurseData(
        id: json['id'],
        DutyDuration: json['dutyDuration'],
        SharePercentage: json['sharePercentage'],
        Salary: json['salary'],
        employee: EmployeeData.fromJson(json['employee']) );
  }
}
