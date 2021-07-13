import 'package:flutter/foundation.dart';
class RoomArguments {
  final int id;
  final String RoomNo;
  final String RoomType;
  final int RoomCapacity;
  final double RoomCharges;

  RoomArguments({
    this.id,
    @required this.RoomNo,
    @required this.RoomType,
    @required this.RoomCapacity,
    @required this.RoomCharges
  });

}
