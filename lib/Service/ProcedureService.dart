import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/model/Room.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;
import '../model/Procedures.dart';

class ProcedureService {
  Future<List<dynamic>> getProcedures() async {
    final response = await http.get(Uri.https(Strings.pathAPI, 'api/procedure'));
    if (response.statusCode == 200) {
      log(response.statusCode);
      List<dynamic> body = jsonDecode(response.body);

      List<Procedures> posts = body
          .map(
            (dynamic item) => Procedures.fromJson(item),
          )
          .toList();
      print(body);
      return body;
    } else {
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

    final response =
        await http.post(Uri.https(Strings.pathAPI, 'api/procedure'),
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
      Uri.https(Strings.pathAPI, 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }

  Future<http.Response> DeleteProcedure(Procedures procedures) {
    return http.delete(
      Uri.https(Strings.pathAPI, 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }
}
