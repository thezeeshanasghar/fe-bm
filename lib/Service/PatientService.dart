import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/PatientRequest.dart';
import 'package:baby_doctor/Models/Responses/PatientResponse.dart';
import 'package:http/http.dart' as http;

class PatientService {
  Future<PatientResponseList> getPatients(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiPatientGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> getPatientById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiPatientGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> insertPatient(PatientRequest patientRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiPatientInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(patientRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> updatePatient(PatientRequest patientRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiPatientUpdate}/${patientRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(patientRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<PatientResponse> deletePatient(int id, String token) async {
    final response =
        await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiPatientDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return PatientResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
