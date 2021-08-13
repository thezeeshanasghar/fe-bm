import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/EmployeeModel.dart';
import 'package:http/http.dart' as http;

class DoctorService {

  // Future<Doctor> getDoctor() async {
  //   final response =
  //   await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/get'));
  //   final jsonResponse = jsonDecode(response.body);
  //   return Doctor.fromJson(jsonResponse);
  // }
  //
  // Future<Doctor> getDoctorById(int Id) async {
  //   final response =
  //   await http.get(Uri.https(Strings.pathAPI, 'api/Doctor/get/${Id}'));
  //   if (response.statusCode == 200) {
  //     final JsonResponse= jsonDecode(response.body);
  //     return Doctor.fromJson(JsonResponse);
  //   } else {
  //     throw Exception('Failed to load Procedure');
  //   }
  // }
  // Future<bool> InsertDoctor(DoctorData doctor) async {
  //
  //   Map<String, dynamic> Obj = {
  //     'consultationFee':doctor.ConsultationFee,
  //     "emergencyConsultationFee":doctor.EmergencyConsultationFee,
  //     "shareInFee":doctor.ShareInFee,
  //     "specialityType":doctor.SpecialityType,
  //     "employee":doctor.employee
  //   };
  //   final response =
  //   await http.post(Uri.https(Strings.pathAPI, 'api/Doctor/insert'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(Obj));
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> UpdateDoctor(DoctorModel doctorModel) async {
  //   Map<String, dynamic> Obj = {
  //     'id': doctorModel.id,
  //     'consultationFee':doctorModel.consultationFee,
  //     "emergencyConsultationFee":doctorModel.emergencyConsultationFee,
  //     "shareInFee":doctorModel.shareInFee,
  //     "specialityType":doctorModel.specialityType,
  //     "employee":doctorModel.employeeModelDetails
  //   };
  //
  //   final response = await http.put(
  //       Uri.https(Strings.pathAPI, 'api/Doctor/update/${doctorModel.id}'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(doctorModel.toJson()));
  //   if (response.statusCode == 204) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<bool> DeleteDoctor(int id) async {
  //   final response = await http.delete(
  //       Uri.https(Strings.pathAPI, 'api/Doctor/delete/${id}'),
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
