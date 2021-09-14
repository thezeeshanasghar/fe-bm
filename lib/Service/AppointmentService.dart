import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/AppointmentResponse.dart';
import 'package:http/http.dart' as http;

class AppointmentService {
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
}
