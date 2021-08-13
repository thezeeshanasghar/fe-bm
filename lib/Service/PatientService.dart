import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:http/http.dart' as http;


class PatientService {
  //
  // Future<Patient> getPatientsInvoices(String Category) async {
  //   final queryParameters = {
  //     'Category': Category,
  //   };
  //   final response =
  //   await http.get(Uri.https(Strings.pathAPI, 'api/Patient/Invoices', queryParameters));
  //   final jsonResponse = jsonDecode(response.body);
  //   return Patient.fromJson(jsonResponse);
  // }
  //
  // Future<Patient> getPatientById(int Id) async {
  //   final response =
  //   await http.get(Uri.https(Strings.pathAPI, 'api/Patient/${Id}'));
  //   if (response.statusCode == 200) {
  //     final JsonResponse = jsonDecode(response.body);
  //     return Patient.fromJson(JsonResponse.data);
  //   } else {
  //     throw Exception('Failed to load Procedure');
  //   }
  // }
  //
  //
  // Future<bool> DeletePatient(int id) async {
  //   final response = await http.delete(
  //       Uri.https(Strings.pathAPI, 'api/Patient/${id}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       });
  //   if (response.statusCode == 204) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}