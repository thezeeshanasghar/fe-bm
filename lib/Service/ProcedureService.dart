import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Room.dart';
import 'package:baby_doctor/Models/Services.dart';
import 'package:http/http.dart' as http;
import '../Models/Procedures.dart';

class ProcedureService {
  Future<List<Procedures>> getProcedures() async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/procedure'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Procedures>((json) => Procedures.fromJson(json))
          .toList();
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
      return true;
    } else {
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

  Future<bool> DeleteProcedure(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/procedure/${id}'),
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
