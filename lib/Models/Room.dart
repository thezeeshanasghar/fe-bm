import 'package:flutter/foundation.dart';
class Room {
  final int id;
  final String RoomNo;
  final String RoomType;
  final int RoomCapacity;
  final double RoomCharges;

  Room({
    this.id,
    @required this.RoomNo,
    @required this.RoomType,
    @required this.RoomCapacity,
    @required this.RoomCharges
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      RoomNo: json['roomNo'],
      RoomType: json['roomType'],
      RoomCapacity: json['roomCapacity'],
      RoomCharges: json['roomCharges'],
    );
  }
}
