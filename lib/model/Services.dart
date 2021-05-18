import 'package:flutter/foundation.dart';
class Services {
  final int id;
  final String ServiceName;
  final String ServiceDescription;


  Services({
    this.id,
    @required this.ServiceName,
    @required this.ServiceDescription,

  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      ServiceName: json['RoomNo'],
      ServiceDescription: json['RoomType'],

    );
  }
}
