import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'model/Procedures.dart';
class HttpService {
  //Procedure Start
  Future<List<Procedures>> getProcedures() async {
    final response =
    await http.get(Uri.https('babymedics.fernflowers.com', 'api/procedure'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log(response.statusCode);
      List<dynamic> body = jsonDecode(response.body);

      List<Procedures> posts = body
          .map(
            (dynamic item) => Procedures.fromJson(item),
      )
          .toList();

      return posts;


    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
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
  //Procedure End
}