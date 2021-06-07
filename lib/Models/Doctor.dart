import 'package:flutter/foundation.dart';
import 'package:baby_doctor/Models/Qualifications.dart';

import 'Employee.dart';


class Doctor {
  final int id;
  final int ConsultationFee;
  final int EmergencyConsultationFee;
  final int ShareInFee;
  final String SpecialityType;
  final Employee employee;

  Doctor(
      {this.id,
        @required this.ConsultationFee,
        @required this.EmergencyConsultationFee,
        @required this.ShareInFee,
        @required this.SpecialityType,
        @required this.employee});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
        id: json['id'],
        ConsultationFee: json['consultationFee'],
        EmergencyConsultationFee: json['emergencyConsultationFee'],
        ShareInFee: json['shareInFee'],
        SpecialityType: json['specialityType'],
        employee: Employee.fromJson(json['employee']) );
  }
}
