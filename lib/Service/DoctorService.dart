import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/DoctorRequest.dart';
import 'package:baby_doctor/Models/Responses/DoctorResponse.dart';
import 'package:http/http.dart' as http;

class DoctorService {
  Future<DoctorResponseList> getDoctors(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiDoctorGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<DoctorResponse> getDoctorById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiDoctorGetId}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<DoctorResponse> insertDoctor(DoctorRequest doctorRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiDoctorInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(doctorRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<DoctorResponse> updateDoctor(DoctorRequest serviceRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiDoctorUpdate}/${serviceRequest.id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(serviceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<DoctorResponse> deleteDoctor(int id, String token) async {
    final response =
        await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiDoctorDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return DoctorResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
