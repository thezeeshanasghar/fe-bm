import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/model/Room.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;
import 'model/Procedures.dart';
class HttpService {
  //Procedure Start
  Future<List<Procedures>> getProcedures() async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/procedure'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log(response.statusCode);
      List<dynamic> body = jsonDecode(response.body);

      List<Procedures> posts = body
          .map(
            (dynamic item) => Procedures.fromJson(item),
      )
          .toList();

      return posts;


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }
  Future<http.Response> InsertProcedure(Procedures procedures) {
    return http.post(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }
  Future<http.Response> UpdateProcedure(Procedures procedures) {
    return http.put(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }
  Future<http.Response> DeleteProcedure(Procedures procedures) {
    return http.delete(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }
  //Procedure End
  //Room Start
  Future<List<Room>> getRooms() async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/room'));
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
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/room/${Id}'));
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
  Future<http.Response> InsertRoom(Room rooms) {
    return http.post(
      Uri.https('babymedics.fernflowers.com', 'api/room'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rooms),
    );
  }
  Future<http.Response> UpdateRooms(Room rooms) {
    return http.put(
      Uri.https('babymedics.fernflowers.com', 'api/room/${rooms.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rooms),
    );
  }
  Future<http.Response> DeleteRoom(Room rooms) {
    return http.delete(
      Uri.https('babymedics.fernflowers.com', 'api/room/${rooms.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rooms),
    );
  }
  //Room End
//Services Start
  Future<List<Services>> getServices() async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/service'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Services> services = body
          .map(
            (dynamic item) => Services.fromJson(item),
      )
          .toList();

      return services;


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }
  Future<List<Services>> getServiceById(int Id) async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/room/${Id}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Services> services = body
          .map(
            (dynamic item) => Services.fromJson(item),
      )
          .toList();

      return services;


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }
  Future<http.Response> InsertServices(Services services) {
    return http.post(
      Uri.https('babymedics.fernflowers.com', 'api/room'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Services),
    );
  }
  Future<http.Response> UpdateServices(Services services) {
    return http.put(
      Uri.https('babymedics.fernflowers.com', 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }
  Future<http.Response> DeleteServices(Services services) {
    return http.delete(
      Uri.https('babymedics.fernflowers.com', 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }
//Services End

}
