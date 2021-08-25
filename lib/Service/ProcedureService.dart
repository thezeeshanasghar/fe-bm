import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ProcedureRequest.dart';
import 'package:baby_doctor/Models/Responses/ProcedureResponse.dart';
import 'package:http/http.dart' as http;

class ProcedureService {
  Future<ProcedureResponseList> getProcedures(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiProcedureGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ProcedureResponse> getProcedureById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiProcedureGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ProcedureResponse> insertProcedure(ProcedureRequest procedureRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiProcedureInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(procedureRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ProcedureResponse> updateProcedure(ProcedureRequest procedureRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiProcedureUpdate}/${procedureRequest.id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(procedureRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ProcedureResponse> deleteProcedure(int id, String token) async {
    final response =
        await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiProcedureDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ProcedureResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
