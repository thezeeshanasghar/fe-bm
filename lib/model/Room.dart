import 'package:flutter/foundation.dart';
class Rooms {
  final int id;
  final String RoomNo;
  final String RoomType;
  final String RoomCapacity;
  final double Charges;

  Rooms({
    this.id,
    @required this.RoomNo,
    @required this.RoomType,
    @required this.RoomCapacity,
    @required this.Charges
  });

  factory Rooms.fromJson(Map<String, dynamic> json) {
    return Rooms(
      id: json['id'],
      RoomNo: json['RoomNo'],
      RoomType: json['RoomType'],
      RoomCapacity: json['RoomCapacity'],
      Charges: json['Charges'],
    );
  }
}
