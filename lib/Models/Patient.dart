import 'package:flutter/foundation.dart';


class Patient {
  final bool isSuccess;
  final String message;
  final List<PatientData> data;

  Patient({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<PatientData> dataList =
    list.map((i) => PatientData.fromJson(i)).toList();
    return Patient(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class PatientData {
  final int id;
  final String Name;
  final String DOB;
  final int PatientId;
  final String FatherHusbandName;
  final int AppointmentId;
  final String Sex;
  final int Discount;
  final int NetAmount;
  final String Category;

  PatientData(
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

  factory PatientData.fromJson(Map<String, dynamic> json) {
    return PatientData(
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