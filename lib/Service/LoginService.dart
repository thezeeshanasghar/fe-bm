import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/LoginRequest.dart';
import 'package:baby_doctor/Models/Responses/LoginResponse.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponseList> getLogins(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiLoginGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return LoginResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<LoginResponse> getLoginById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiLoginGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<LoginResponse> insertLogin(LoginRequest loginRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiLoginInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<LoginResponse> updateLogin(LoginRequest loginRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiLoginUpdate}/${loginRequest.id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<LoginResponse> deleteLogin(int id, String token) async {
    final response =
    await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiLoginDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return LoginResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
