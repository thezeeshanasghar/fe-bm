import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';

import 'package:baby_doctor/Models/Requests/AuthenticateRequest.dart';
import 'package:baby_doctor/Models/Responses/AuthenticateResponse.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<AuthenticateResponse> authenticateLogin(AuthenticateLoginRequest loginRequest) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiAuthenticationLogin),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
        },
        body: jsonEncode(loginRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AuthenticateResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AuthenticateResponse> authenticateRefresh(AuthenticateRefreshRequest refreshRequest) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiAuthenticationRefresh),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
        },
        body: jsonEncode(refreshRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AuthenticateResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
