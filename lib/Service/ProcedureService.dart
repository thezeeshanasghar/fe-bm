import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/model/Room.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;
import '../model/Procedures.dart';

class ProcedureService {
  //Procedure Start
  Future<List<Procedures>> getProcedures() async {
    final response = await http
        .get(Uri.https('babymedics.fernflowers.com', 'api/procedure'));
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

  Future<bool> InsertProcedure(Procedures procedures) async {

    Map<String, dynamic> Obj = {
      'name': procedures.name,
      'performedBy': procedures.performedBy,
      'charges': procedures.charges,
      'performerShare': procedures.performerShare
    };

    final response = await http.post(Uri.https('babymedics.fernflowers.com', 'api/procedure'),
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

}
