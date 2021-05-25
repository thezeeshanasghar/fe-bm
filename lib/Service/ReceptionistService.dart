import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:http/http.dart' as http;
import '../Models/Employee.dart';

class ReceptionistService {
  Future<List<Employee>> getReceptionist() async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Employee'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<Employee>((json) => Employee.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Employee');
    }
  }
  Future<dynamic> getReceptionistById(int Id) async {
    final response =
    await http.get(Uri.https(Strings.pathAPI, 'api/Employee/${Id}'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Employee');
    }
  }
  Future<bool> InsertReceptionist(Employee employee) async {

    Map<String, dynamic> Obj = {
    'employeeType':employee.employeeType,
      "firstName":employee.firstName,
      "lastName":employee.lastName,
      "fatherHusbandName":employee.fatherHusbandName,
      "gender":employee.gender,
      "CNIC":employee.CNIC,
      "contact":employee.contact,
      "emergencyContact":employee.emergencyContact,
      "experience":employee.experience,
      "flourNo":employee.flourNo,
      "password":employee.password,
      "userName":employee.userName,
      "joiningDate":employee.joiningDate,
      "address":employee.address,
      "email":employee.email,
    };
    final response =
    await http.post(Uri.https(Strings.pathAPI, 'api/Employee'),
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
  Future<bool> UpdateReceptionist(Employee employee) async {
    Map<String, dynamic> Obj = {
      'id':employee.id,
      'employeeType':employee.employeeType,
      "firstName":employee.firstName,
      "lastName":employee.lastName,
      "fatherHusbandName":employee.fatherHusbandName,
      "gender":employee.gender,
      "CNIC":employee.CNIC,
      "contact":employee.contact,
      "emergencyContact":employee.emergencyContact,
      "experience":employee.experience,
      "flourNo":employee.flourNo,
      "password":employee.password,
      "userName":employee.userName,
      "joiningDate":employee.joiningDate,
      "address":employee.address,
      "email":employee.email,
    };
    final response =
    await http.put(Uri.https(Strings.pathAPI, 'api/Employee/${employee.id}'),
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
  Future<bool> DeleteReceptionist(int id) async {
    final response = await http.delete(
        Uri.https(Strings.pathAPI, 'api/Employee/${id}'),
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
