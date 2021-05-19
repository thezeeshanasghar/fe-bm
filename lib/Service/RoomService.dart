import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/model/Room.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;
import '../model/Room.dart';

class RoomService {
  Future<List<Room>> getRooms() async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/room'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Room> posts = body
          .map(
            (dynamic item) => Room.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }

  Future<List<Room>> getRoomsById(int Id) async {
    final response = await http
        .get(Uri.https(Strings.pathAPI, 'api/room/${Id}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Room> posts = body
          .map(
            (dynamic item) => Room.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }

  Future<bool> InsertRoom(Room rooms) async {
    Map<String, dynamic> Obj = {
      'RoomNo': rooms.RoomNo,
      'RoomType': rooms.RoomType,
      'charges': rooms.RoomCapacity,
      'performerShare': rooms.Charges
    };

    final response =
        await http.post(Uri.https(Strings.pathAPI, 'api/room'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(Obj));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return false;
    }
  }

  Future<http.Response> UpdateRooms(Room rooms) {
    return http.put(
      Uri.https(Strings.pathAPI, 'api/room/${rooms.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rooms),
    );
  }

  Future<http.Response> DeleteRoom(Room rooms) {
    return http.delete(
      Uri.https(Strings.pathAPI, 'api/room/${rooms.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rooms),
    );
  }
}
