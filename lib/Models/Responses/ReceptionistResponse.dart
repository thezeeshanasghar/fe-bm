import 'package:baby_doctor/Models/Sample/ReceptionistSample.dart';

class ReceptionistResponse {
  final bool isSuccess;
  final String message;
  final ReceptionistSample data;

  ReceptionistResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ReceptionistResponse.fromJson(Map<String, dynamic> json) {
    return ReceptionistResponse(isSuccess: json['isSuccess'], message: json['message'], data: json['data']);
  }
}

class ReceptionistResponseList {
  final bool isSuccess;
  final String message;
  final List<ReceptionistSample> data;

  ReceptionistResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory ReceptionistResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ReceptionistSample> dataList = list.map((i) => ReceptionistSample.fromJson(i)).toList();
    return ReceptionistResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
