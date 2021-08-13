import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Doctor.dart';
import 'package:baby_doctor/Models/Requests/AuthenticateRequest.dart';
import 'package:baby_doctor/Models/Requests/EmployeeModel.dart';
import 'package:baby_doctor/Models/Responses/AuthenticateResponse.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<AuthenticateResponse> authenticateLogin(
      AuthenticateLoginRequest loginRequest) async {
    final response = await http.post(
        Uri.https(Strings.pathAPI, Strings.apiAuthenticationLogin),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
        },
        body: jsonEncode(loginRequest.toJson()));

    final JsonResponse = jsonDecode(response.body);
    return AuthenticateResponse.fromJson(JsonResponse);
  }
}
