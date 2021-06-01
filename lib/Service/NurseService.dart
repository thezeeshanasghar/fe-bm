import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Nurse.dart';
import 'package:http/http.dart' as http;

class NurseService {
  Future<List<Nurse>> getNurse() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Nurse'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Nurse>((json) => Nurse.fromJson(json)).toList();

    } else {
      throw Exception('Failed to load Employee');
    }
  }

  Future<Nurse> getNurseById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Nurse/${Id}'));
    if (response.statusCode == 200) {
      final JsonResponse= jsonDecode(response.body);
      return Nurse.fromJson(JsonResponse);
    } else {
      throw Exception('Failed to load Procedure');
    }
  }

  Future<bool> InsertNurse(Nurse nurse) async {
    Map<String, dynamic> Obj = {
      'dutyDuration':nurse.DutyDuration,
      "sharePercentage":nurse.SharePercentage,
      "salary":nurse.Salary,
      "employee":nurse.employee
    };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/Nurse'),
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

  Future<bool> UpdateNurse(Nurse nurse) async {
    Map<String, dynamic> Obj = {
      'id':nurse.id,
      'dutyDuration':nurse.DutyDuration,
      "sharePercentage":nurse.SharePercentage,
      "salary":nurse.Salary,
      "employee":nurse.employee
    };
    final response =
    await http.put(Uri.https(Strings.pathAPI, 'api/Nurse/${nurse.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeleteNurse(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/Nurse/${id}'),
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
