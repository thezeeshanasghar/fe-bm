
import 'package:baby_doctor/Models/Sample/DoctorSample.dart';
import 'package:baby_doctor/Models/Sample/PatientSample.dart';

class ReceiptSample {
  int id;
  int patientId;
  int receiptionistId;
  int doctorId;
  int invoiceId;

  String pmid;
  int discount;
  int totalAmount;
  int pendingAmount;
  int paidAmount;

  DoctorSample doctor;
  PatientSample patient;

  ReceiptSample(
      {this.id,
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
        this.patient});

  ReceiptSample.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    receiptionistId = json['receiptionistId'];
    doctorId = json['doctorId'];
    invoiceId = json['invoiceId'];
    pmid = json['pmid'];
    discount = json['discount'];
    totalAmount = json['totalAmount'];
    pendingAmount = json['pendingAmount'];
    paidAmount = json['paidAmount'];
    doctor = json['doctor'] != null
        ? new DoctorSample.fromJson(json['doctor'])
        : null;
    patient = json['patient'] != null
        ? new PatientSample.fromJson(json['patient'])
        : null;
  }
}
