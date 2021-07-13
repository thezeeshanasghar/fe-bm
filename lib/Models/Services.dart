import 'package:flutter/foundation.dart';
class ServiceResponse {
  final bool isSuccess;
  final String message;
  final List<ServiceData> data;

  ServiceResponse({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ServiceData> dataList =
    list.map((i) => ServiceData.fromJson(i)).toList();
    return ServiceResponse(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class ServiceData {
  final int id;
  final String name;
  final String description;


  ServiceData({
    this.id,
    @required this.name,
    @required this.description,

  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'],
      name: json['name'],
      description: json['description'],

    );
  }
}
