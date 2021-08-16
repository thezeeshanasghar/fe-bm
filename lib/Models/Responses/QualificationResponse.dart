import 'package:baby_doctor/Models/Sample/QualificationSample.dart';

class QualificationResponse {
  final bool isSuccess;
  final String message;
  final QualificationSample data;

  QualificationResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory QualificationResponse.fromJson(Map<String, dynamic> json) {
    return QualificationResponse(isSuccess: json['isSuccess'], message: json['message'], data: json['data']);
  }
}

class QualificationResponseList {
  final bool isSuccess;
  final String message;
  final List<QualificationSample> data;

  QualificationResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory QualificationResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<QualificationSample> dataList = list.map((i) => QualificationSample.fromJson(i)).toList();
    return QualificationResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
