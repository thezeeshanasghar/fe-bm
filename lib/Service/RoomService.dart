import 'dart:convert';
import 'dart:math';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Room.dart';
import 'package:http/http.dart' as http;
import '../Models/Room.dart';

class RoomService {
  Future<List<Room>> getRooms() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/room'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Room>((json) => Room.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Room');
    }
  }
  Future<dynamic> getRoomById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/room/${Id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Room');
    }
  }

  Future<bool> InsertRoom(Room rooms) async {
    Map<String, dynamic> Obj = {
      'RoomNo': rooms.RoomNo,
      'RoomType': rooms.RoomType,
      'RoomCapacity': rooms.RoomCapacity,
      'RoomCharges': rooms.RoomCharges
    };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/room'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> UpdateRoom(Room rooms) async {
    Map<String, dynamic> Obj = {
      'id':rooms.id,
      'RoomNo': rooms.RoomNo,
      'RoomType': rooms.RoomType,
      'RoomCapacity': rooms.RoomCapacity,
      'RoomCharges': rooms.RoomCharges
    };
    final response =
    await http.put(Uri.https(Strings.pathAPI, 'api/room/${rooms.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode ==204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> Deleteroom(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/room/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
