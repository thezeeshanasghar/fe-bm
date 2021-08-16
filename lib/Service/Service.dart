import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ServiceRequest.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<ServiceResponse> getServices() async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/service/get'));
    final jsonResponse = jsonDecode(response.body);
    return ServiceResponse.fromJson(jsonResponse);
  }

//
// Future<dynamic> getServicesById(int Id) async {
//   final response =
//       await http.get(Uri.https(Strings.pathAPI, 'api/service/get/${Id}'));
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to load Service');
//   }
// }
//
  Future<ServiceResponse> InsertServices(ServiceRequest serviceRequest) async {
    final response =
        await http.post(Uri.https(Strings.pathAPI, 'api/service/insert'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(serviceRequest.toJson()));
    final jsonResponse = jsonDecode(response.body);
    return ServiceResponse.fromJson(jsonResponse);
  }
//
// Future<bool> UpdateServices(ServiceData services) async{
//     Map<String, dynamic> Obj = {
//       'id':services.id,
//       'name': services.name,
//       'description': services.description,
//     };
//     final response = await http.put(Uri.https(Strings.pathAPI, 'api/service/update/${services.id}'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(Obj));
//     if (response.statusCode ==204) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//
//   Future<bool> DeleteServices(int id) async {
//   final response = await http.delete(
//       Uri.https(Strings.pathAPI, 'api/service/delete/${id}'),
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
