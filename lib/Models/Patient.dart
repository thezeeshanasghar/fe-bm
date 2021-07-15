import 'package:flutter/foundation.dart';

class Patient {
  final int id;
  final String Name;
  final String DOB;
  final PatientId;
  final String FatherHusbandName;
  final String AppointmentId;
  final String Sex;
  final int Discount;
  final int NetAmount;
  final String Category;

  Patient(
      {this.id,
        @required this.Name,
        @required this.DOB,
        @required this.PatientId,
        @required this.FatherHusbandName,
        @required this.AppointmentId,
        @required this.Sex,
        @required this.Discount,
        @required this.NetAmount,
        @required this.Category
       });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['id'],
        Name: json['name'],
        DOB: json['dob'],
        PatientId: json['patientId'],
        FatherHusbandName: json['fatherHusbandName'],
        AppointmentId: json['appointmentId'],
        Sex: json['sex'],
        Discount: json['discount'],
        NetAmount: json['netAmount'],
        Category: json['category']
         );
  }
}