import 'dart:convert';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/InvoiceRequest.dart';
import 'package:baby_doctor/Models/Responses/InvoiceResponse.dart';
import 'package:http/http.dart' as http;

class InvoiceService {
  Future<InvoiceResponseList> getInvoices(String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, Strings.apiInvoiceGet),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponseList.fromJson(jsonResponse);
    }
    return null;
  }

  Future<InvoiceResponse> getInvoiceById(int id, String token) async {
    final response = await http.get(
      Uri.https(Strings.pathAPI, '${Strings.apiInvoiceGetId}/$id'),
      headers: <String, String>{
        Strings.apiContentType: Strings.apiApplicationJson,
        Strings.apiAuthorization: '${Strings.apiBearer} $token',
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<InvoiceResponse> insertInvoice(InvoiceRequest invoiceRequest, String token) async {
    final response = await http.post(Uri.https(Strings.pathAPI, Strings.apiInvoiceInsert),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(invoiceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<InvoiceResponse> updateInvoice(InvoiceRequest invoiceRequest, String token) async {
    final response = await http.put(Uri.https(Strings.pathAPI, '${Strings.apiInvoiceUpdate}/${invoiceRequest.Id}'),
        headers: <String, String>{
          Strings.apiContentType: Strings.apiApplicationJson,
          Strings.apiAuthorization: '${Strings.apiBearer} $token',
        },
        body: jsonEncode(invoiceRequest.toJson()));
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponse.fromJson(jsonResponse);
    }
    return null;
  }

  Future<InvoiceResponse> deleteInvoice(int id, String token) async {
    final response =
    await http.delete(Uri.https(Strings.pathAPI, '${Strings.apiInvoiceDelete}/$id'), headers: <String, String>{
      Strings.apiContentType: Strings.apiApplicationJson,
      Strings.apiAuthorization: '${Strings.apiBearer} $token',
    });
    if (response.statusCode >= 200 && response.statusCode < 227) {
      final jsonResponse = jsonDecode(response.body);
      return InvoiceResponse.fromJson(jsonResponse);
    }
    return null;
  }
}
