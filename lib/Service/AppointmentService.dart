import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/AppointmentSearchRequest.dart';
import 'package:baby_doctor/Models/Responses/AppointmentResponse.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
  Future<AppointmentResponseList> getAppointments(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiAppointmentGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AppointmentResponseList> getPatientAppointmentsByCategory(
      String token, String Category) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiPatientGetCategory}/$Category'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AppointmentResponseList> getPatientAppointmentsBySearch(
      AppointmentSearchRequest appointmentSearchRequest, String token) async {
    final response = await http.post(
        Uri.https(Strings.pathAPI, Strings.apiPatientPostSearch),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(appointmentSearchRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<AppointmentResponseList> getAppointmentsBySearch(
      String token, String search) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiPatientGetSearch}/$search'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return AppointmentResponseList.fromJson(jsonResponse);
    }
    return null;
  }
}
