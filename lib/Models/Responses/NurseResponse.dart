import 'package:baby_doctor/Models/Sample/NurseSample.dart';

class NurseResponse {
  final bool isSuccess;
  final String message;
  final NurseSample data;

  NurseResponse({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory NurseResponse.fromJson(Map<String, dynamic> json) {
    return NurseResponse(
        isSuccess: json['isSuccess'],
        message: json['message'],
        data: json['data'] != null ? NurseSample.fromJson(json['data']) : null);
  }
}

class NurseResponseList {
  final bool isSuccess;
  final String message;
  final List<NurseSample> data;

  NurseResponseList({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory NurseResponseList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<NurseSample> dataList = list.map((i) => NurseSample.fromJson(i)).toList();
    return NurseResponseList(isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}
