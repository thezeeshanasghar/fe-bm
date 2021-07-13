import 'package:flutter/foundation.dart';


class Room {
  final bool isSuccess;
  final String message;
  final List<RoomData> data;

  Room({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<RoomData> dataList =
    list.map((i) => RoomData.fromJson(i)).toList();
    return Room(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}


class RoomData {
  final int id;
  final String RoomNo;
  final String RoomType;
  final int RoomCapacity;
  final double RoomCharges;

  RoomData({
    this.id,
    @required this.RoomNo,
    @required this.RoomType,
    @required this.RoomCapacity,
    @required this.RoomCharges
  });

  factory RoomData.fromJson(Map<String, dynamic> json) {
    return RoomData(
      id: json['id'],
      RoomNo: json['roomNo'],
      RoomType: json['roomType'],
      RoomCapacity: json['roomCapacity'],
      RoomCharges: json['roomCharges'],
    );
  }
}
