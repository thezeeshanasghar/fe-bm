import 'package:flutter/foundation.dart';

class Procedure {
  final bool isSuccess;
  final String message;
  final List<ProcedureData> data;

  Procedure({
    this.isSuccess,
    this.message,
    this.data,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<ProcedureData> dataList =
        list.map((i) => ProcedureData.fromJson(i)).toList();
    return Procedure(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}

class ProcedureData {
  final int id;
  final String name;
  final String performedBy;
  final int charges;
  final int performerShare;

  ProcedureData(
      {this.id,
      this.name,
      this.performedBy,
      this.charges,
      this.performerShare});

  factory ProcedureData.fromJson(Map<String, dynamic> json) {
    return ProcedureData(
      id: json['id'],
      name: json['name'],
      performerShare: json['performerShare'],
      performedBy: json['performedBy'],
      charges: json['charges'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "performerShare": performerShare,
        "performedBy": performedBy,
        "charges": charges
      };
}
