import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/ProcedureResponse.dart';
import 'package:http/http.dart' as http;

class ProcedureService {
  Future<Procedure> getProcedures() async {
    final response = await http.get(Uri.https(Strings.pathAPI, 'api/procedure/get'));
    final jsonResponse = jsonDecode(response.body);
    return Procedure.fromJson(jsonResponse);
  }

  Future<dynamic> getProceduresById(int Id) async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/procedure/get/${Id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Room');
    }

  }

  Future<bool> InsertProcedure(ProcedureData procedures) async {
    Map<String, dynamic> Obj = {
      'name': procedures.name,
      'performedBy': procedures.performedBy,
      'charges': procedures.charges,
      'performerShare': procedures.performerShare
    };
    final response =
        await http.post(Uri.https(Strings.pathAPI, 'api/procedure/insert'),
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

  Future<bool> UpdateProcedure(ProcedureData procedures) async {
    Map<String, dynamic> Obj = {
      'id': procedures.id,
      'name': procedures.name,
      'performedBy': procedures.performedBy,
      'charges': procedures.charges,
      'performerShare': procedures.performerShare
    };
    final response = await http.put(
        Uri.https(Strings.pathAPI, 'api/procedure/update/${procedures.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeleteProcedure(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/procedure/delete/${id}'),
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
