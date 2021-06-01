import 'package:flutter/foundation.dart';
import 'Employee.dart';
class Nurse {
  final int id;
  final int DutyDuration;
  final int SharePercentage;
  final int Salary;
  final Employee employee;

  Nurse(
      {this.id,
        @required this.DutyDuration,
        @required this.SharePercentage,
        @required this.Salary,
        @required this.employee});

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
        id: json['id'],
        DutyDuration: json['dutyDuration'],
        SharePercentage: json['sharePercentage'],
        Salary: json['salary'],
        employee: Employee.fromJson(json['employee']) );
  }
}
