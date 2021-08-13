import 'package:baby_doctor/Models/Sample/ReceiptSample.dart';

class RefundSample {
  final int id;
  final int receiptId;

  final double refundAmount;
  final double finalAmount;

  final ReceiptSample receipt;

  RefundSample({
    this.id,
    this.receiptId,
    this.refundAmount,
    this.finalAmount,
    this.receipt,
  });

  factory RefundSample.fromJson(Map<String, dynamic> json) {
    return RefundSample(
      id: json['id'],
      receiptId: json['receiptId'],
      refundAmount: json['refundAmount'],
      finalAmount: json['finalAmount'],
      receipt: json['receipt'],
    );
  }
}
