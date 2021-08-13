import 'package:baby_doctor/Models/Sample/ReceiptSample.dart';

class ServiceSample {
  final int id;
  final int receiptId;

  final double refundAmount;
  final double finalAmount;

  final ReceiptSample receipt;

  ServiceSample({
    this.id,
    this.receiptId,
    this.refundAmount,
    this.finalAmount,
    this.receipt,
  });

  factory ServiceSample.fromJson(Map<String, dynamic> json) {
    return ServiceSample(
      id: json['id'],
      receiptId: json['receiptId'],
      refundAmount: json['refundAmount'],
      finalAmount: json['finalAmount'],
      receipt: json['receipt'],
    );
  }
}
