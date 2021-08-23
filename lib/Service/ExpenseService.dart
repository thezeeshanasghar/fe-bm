import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ExpenseRequest.dart';
import 'package:baby_doctor/Models/Responses/ExpenseResponse.dart';
import 'package:http/http.dart' as http;

class ExpenseService {
  Future<ExpenseResponseList> getExpenses(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiExpenseGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> getExpenseById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiExpenseGet}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> insertExpense(ExpenseRequest expenseRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiExpenseInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(expenseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> updateExpense(ExpenseRequest expenseRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiExpenseUpdate}/${expenseRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(expenseRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<ExpenseResponse> deleteExpense(int id, String token) async {
    final response =
    await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiExpenseDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return ExpenseResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
