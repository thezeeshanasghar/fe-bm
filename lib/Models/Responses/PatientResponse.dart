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
    return PatientResponse(isSuccess: json['isSuccess'], message: json['message'], data: json['data']);
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
    var list = json['data'] as List;
    List<PatientSample> dataList = list.map((i) => PatientSample.fromJson(i)).toList();
    return PatientResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
