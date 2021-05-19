import 'dart:convert';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;

class Service {



  Future<List<Services>> getServices() async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/service'));
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
        .get(Uri.https('babymedics.fernflowers.com', 'api/room/${Id}'));
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

  Future<http.Response> InsertServices(Services services) {
    return http.post(
      Uri.https('babymedics.fernflowers.com', 'api/room'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Services),
    );
  }

  Future<http.Response> UpdateServices(Services services) {
    return http.put(
      Uri.https('babymedics.fernflowers.com', 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }

  Future<http.Response> DeleteServices(Services services) {
    return http.delete(
      Uri.https('babymedics.fernflowers.com', 'api/room/${services.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(services),
    );
  }


}
