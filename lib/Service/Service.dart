import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ServiceRequest.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<ServiceResponseList> getServices(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiServiceGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ServiceResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ServiceResponse> getServicesById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiServiceGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ServiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ServiceResponse> insertService(ServiceRequest serviceRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiServiceInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(serviceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ServiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ServiceResponse> updateService(ServiceRequest serviceRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiServiceUpdate}/${serviceRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(serviceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ServiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ServiceResponse> deleteService(int id, String token) async {
    final response =
        await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiServiceDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ServiceResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
