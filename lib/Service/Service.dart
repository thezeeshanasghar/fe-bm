import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;

class Service {
  Future<List<Services>> getServices() async {
    final response =
        await http.get(Uri.https(Strings.pathAPI, 'api/service'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Services> services = body
          .map(
            (dynamic item) => Services.fromJson(item),
          )
          .toList();

      return services;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }

  Future<List<Services>> getServiceById(int Id) async {
    final response = await http
        .get(Uri.https(Strings.pathAPI, 'api/room/${Id}'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Services> services = body
          .map(
            (dynamic item) => Services.fromJson(item),
          )
          .toList();

      return services;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Procedure');
    }
  }

  Future<bool> InsertServices(Services services) async{
    Map<String, dynamic> Obj = {
      'name': services.name,
      'description': services.description,

    };

    final response =
        await http.post(Uri.https(Strings.pathAPI, 'api/service'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(Obj));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return true;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return false;
    }
  }

  Future<http.Response> UpdateServices(Services services) {
    return http.put(
      Uri.https(Strings.pathAPI, 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }

  Future<http.Response> DeleteServices(Services services) {
    return http.delete(
      Uri.https(Strings.pathAPI, 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }
}
