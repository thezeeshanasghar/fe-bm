import 'package:flutter/foundation.dart';
class Room {
  final int id;
  final String RoomNo;
  final String RoomType;
  final double RoomCapacity;
  final double Charges;

  Room({
    this.id,
    @required this.RoomNo,
    @required this.RoomType,
    @required this.RoomCapacity,
    @required this.Charges
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      RoomNo: json['RoomNo'],
      RoomType: json['RoomType'],
      RoomCapacity: json['RoomCapacity'],
      Charges: json['Charges'],
    );
  }
}
