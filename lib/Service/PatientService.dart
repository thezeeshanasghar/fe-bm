import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Patient.dart';
import 'package:http/http.dart' as http;


class PatientService {

  Future<List<Patient>> getPatientsInvoices() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Patient/Invoices'));
    if (response.statusCode == 200) {
      //print(response.body ['data'] as List);
      final parsed = (jsonDecode(response.body)['data'] as List).cast<Map<String, dynamic>>();
      return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<Patient> getPatientById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Patient/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse = jsonDecode(response.body);
      return Patient.fromJson(JsonResponse.data);
    } else {
      throw Exception('Failed to load Procedure');
    }
  }


  Future<bool> DeletePatient(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/Patient/${id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}