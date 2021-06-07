import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Doctor.dart';
import 'package:baby_doctor/Models/Request/EmployeeModel.dart';
import 'package:http/http.dart' as http;
import '../Models/Employee.dart';

class DoctorService {

  Future<List<Doctor>> getDoctor() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Doctor>((json) => Doctor.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<Doctor> getDoctorById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse= jsonDecode(response.body);
      return Doctor.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Procedure');
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

  Future<bool> UpdateDoctor(DoctorModel doctorModel) async {
    final response = await http.put(
        Uri.https(Strings.pathAPI, 'api/Doctor/${doctorModel.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(doctorModel.toJson()));
    if (response.statusCode == 204) {
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
