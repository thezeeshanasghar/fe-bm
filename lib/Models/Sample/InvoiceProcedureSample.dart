import 'package:baby_doctor/Models/Sample/InvoiceSample.dart';
import 'package:baby_doctor/Models/Sample/ProcedureSample.dart';

class InvoiceProcedureSample {
  final int id;
  final int userId;
  final int invoiceId;

  final InvoiceSample invoice;
  final ProcedureSample procedures;

  InvoiceProcedureSample({
    this.id,
    this.userId,
    this.invoiceId,
    this.invoice,
    this.procedures,
  });

  factory InvoiceProcedureSample.fromJson(Map<String, dynamic> json) {
    return InvoiceProcedureSample(
      id: json['id'],
      userId: json['userId'],
      invoiceId: json['invoiceId'],
      invoice: json['invoice'] != null ? InvoiceSample.fromJson(json['invoice']) : null,
      procedures: json['procedures'] != null ? ProcedureSample.fromJson(json['procedures']) : null,
    );
  }
}
