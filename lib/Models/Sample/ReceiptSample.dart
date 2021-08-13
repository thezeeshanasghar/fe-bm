import 'package:baby_doctor/Models/Sample/DoctorSample.dart';
import 'package:baby_doctor/Models/Sample/PatientSample.dart';

class ReceiptSample {
  final int id;
  final int patientId;
  final int receiptionistId;
  final int doctorId;
  final int invoiceId;

  final String pmid;
  final double discount;
  final int totalAmount;
  final int pendingAmount;
  final int paidAmount;

  final DoctorSample doctor;
  final PatientSample patient;

  ReceiptSample({
    this.id,
    this.patientId,
    this.receiptionistId,
    this.doctorId,
    this.invoiceId,
    this.pmid,
    this.discount,
    this.totalAmount,
    this.pendingAmount,
    this.paidAmount,
    this.doctor,
    this.patient,
  });

  factory ReceiptSample.fromJson(Map<String, dynamic> json) {
    return ReceiptSample(
      id: json['id'],
      patientId: json['patientId'],
      receiptionistId: json['receiptionistId'],
      doctorId: json['doctorId'],
      invoiceId: json['invoiceId'],
      pmid: json['pmid'],
      discount: json['discount'],
      totalAmount: json['totalAmount'],
      pendingAmount: json['pendingAmount'],
      paidAmount: json['paidAmount'],
      doctor: json['doctor'],
      patient: json['patient'],
    );
  }
}
