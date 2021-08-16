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
    return ProcedureResponse(isSuccess: json['isSuccess'], message: json['message'], data: json['data']);
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
    var list = json['data'] as List;
    List<ProcedureSample> dataList = list.map((i) => ProcedureSample.fromJson(i)).toList();
    return ProcedureResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
