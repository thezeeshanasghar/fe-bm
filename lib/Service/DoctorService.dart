import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Doctor.dart';
import 'package:http/http.dart' as http;
import '../Models/Employee.dart';

class DoctorService {
  Future<List<Doctor>> getDoctor() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Employee>((json) => Employee.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Employee');
    }
  }
  Future<dynamic> getDoctorById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/${Id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Doctor');
    }
  }
  Future<bool> InsertDoctor(Doctor doctor) async {

    Map<String, dynamic> Obj = {
      'consultationFee':doctor.ConsultationFee,
      "emergencyConsultationFee":doctor.EmergencyConsultationFee,
      "shareInFee":doctor.ShareInFee,
      "specialityType":doctor.SpecialityType,
      "employee":doctor.employee
    };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/Doctor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> UpdateDoctor(Doctor doctor) async {
    Map<String, dynamic> Obj = {
      'id':doctor.id,
      'consultationFee':doctor.ConsultationFee,
      "emergencyConsultationFee":doctor.EmergencyConsultationFee,
      "shareInFee":doctor.ShareInFee,
      "specialityType":doctor.SpecialityType,
      "employee":doctor.employee
    };
    final response =
    await http.put(Uri.https(Strings.pathAPI, 'api/Doctor/${doctor.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> DeleteDoctor(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/Doctor/${id}'),
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
