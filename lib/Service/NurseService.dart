import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/NurseRequest.dart';
import 'package:baby_doctor/Models/Responses/NurseResponse.dart';
import 'package:http/http.dart' as http;

class NurseService {
  Future<NurseResponseList> getNurses(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiNurseGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return NurseResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<NurseResponse> getNurseById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiNurseGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return NurseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<NurseResponse> insertNurse(NurseRequest nurseRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiNurseInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(nurseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return NurseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<NurseResponse> updateNurse(NurseRequest nurseRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiNurseUpdate}/${nurseRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(nurseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return NurseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<NurseResponse> deleteNurse(int id, String token) async {
    final response =
        await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiNurseDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return NurseResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
