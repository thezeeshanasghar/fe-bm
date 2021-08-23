import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ReceptionistRequest.dart';
import 'package:baby_doctor/Models/Responses/ReceptionistResponse.dart';
import 'package:http/http.dart' as http;

class ReceptionistService {
  Future<ReceptionistResponseList> getReceptionists(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiReceptionistGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ReceptionistResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ReceptionistResponse> getReceptionistById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiReceptionistGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ReceptionistResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ReceptionistResponse> insertReceptionist(ReceptionistRequest receptionistRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiReceptionistInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(receptionistRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ReceptionistResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ReceptionistResponse> updateReceptionist(ReceptionistRequest receptionistRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiReceptionistUpdate}/${receptionistRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(receptionistRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ReceptionistResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ReceptionistResponse> deleteReceptionist(int id, String token) async {
    final response =
    await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiReceptionistDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ReceptionistResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
