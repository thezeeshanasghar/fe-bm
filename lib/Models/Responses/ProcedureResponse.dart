import 'package:baby_doctor/Models/Sample/ProcedureSample.dart';

class ProcedureResponse {
  final bool isSuccess;
  final String message;
  final ProcedureSample data;

  ProcedureResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ProcedureResponse.fromJson(Map<String, dynamic> json) {
    return ProcedureResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null
            ? ProcedureSample.fromJson(json['data'])
            : null);
  }
}

class ProcedureResponseList {
  final bool isSuccess;
  final String message;
  final List<ProcedureSample> data;

  ProcedureResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ProcedureResponseList.fromJson(Map<String, dynamic> json) {
    List<ProcedureSample> dataList;
    if (json['data'] != null) {
      var list = json['data'] as List;
      dataList = list.map((i) => ProcedureSample.fromJson(i)).toList();
    }
    return ProcedureResponseList(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
