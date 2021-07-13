import 'package:flutter/foundation.dart';
import 'package:baby_doctor/Models/Qualifications.dart';

import 'Employee.dart';

class Doctor {
  final bool isSuccess;
  final String message;
  final List<DoctorData> data;

  Doctor({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<DoctorData> dataList =
    list.map((i) => DoctorData.fromJson(i)).toList();
    return Doctor(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class DoctorData {
  final int id;
  final int ConsultationFee;
  final int EmergencyConsultationFee;
  final int ShareInFee;
  final String SpecialityType;
  final EmployeeData employee;

  DoctorData(
      {
        this.id,
        @required this.ConsultationFee,
        @required this.EmergencyConsultationFee,
        @required this.ShareInFee,
        @required this.SpecialityType,
        @required this.employee});

  factory DoctorData.fromJson(Map<String, dynamic> json) {
    return DoctorData(
        id: json['id'],
        ConsultationFee: json['consultationFee'],
        EmergencyConsultationFee: json['emergencyConsultationFee'],
        ShareInFee: json['shareInFee'],
        SpecialityType: json['specialityType'],
        employee: EmployeeData.fromJson(json['employee']) );
  }
}
