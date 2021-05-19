import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/model/Room.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:http/http.dart' as http;
import '../model/Procedures.dart';

class ProcedureService {
  Future<List<Procedures>> getProcedures() async {
    final response = await http
        .get(Uri.https('babymedics.fernflowers.com', 'api/procedure'));
    if (response.statusCode == 200) {
      log(response.statusCode);
      List<dynamic> body = jsonDecode(response.body);

      List<Procedures> posts = body
          .map(
            (dynamic item) => Procedures.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw Exception('Failed to load Procedure');
    }
  }

  Future<http.Response> InsertProcedure(Procedures procedures) {
    return http.post(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }

  Future<http.Response> UpdateProcedure(Procedures procedures) {
    return http.put(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }

  Future<http.Response> DeleteProcedure(Procedures procedures) {
    return http.delete(
      Uri.https('babymedics.fernflowers.com', 'api/procedure'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(procedures),
    );
  }
}
