import 'package:baby_doctor/Models/Sample/PatientSample.dart';

class PatientResponse {
  final bool isSuccess;
  final String message;
  final PatientSample data;

  PatientResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return PatientResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? PatientSample.fromJson(json['data']) : null);
  }
}

class PatientResponseList {
  final bool isSuccess;
  final String message;
  final List<PatientSample> data;

  PatientResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory PatientResponseList.fromJson(Map<String, dynamic> json) {
    List<PatientSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => PatientSample.fromJson(i)).toList();
    }
    return PatientResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
