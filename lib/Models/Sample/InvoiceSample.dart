
import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';
import 'package:baby_doctor/Models/Sample/DoctorSample.dart';
import 'package:baby_doctor/Models/Sample/PatientSample.dart';
import 'package:baby_doctor/Models/Sample/ReceiptSample.dart';

class InvoiceSample {
  final int id;
  final int appointmentId;
  final int doctorId;
  final int patientId;
  final int receptionistId;

  final String date;
  final String checkupType;
  final double checkupFee;
  final String paymentType;
  final double disposibles;
  final double grossAmount;

  final AppointmentSample appointmentSample;
  final DoctorSample doctorSample;
  final ReceiptSample receiptSample;
  final PatientSample patientSample;

  InvoiceSample({
    this.id,
    this.appointmentId,
    this.doctorId,
    this.patientId,
    this.date,
    this.checkupType,
    this.checkupFee,
    this.paymentType,
    this.disposibles,
    this.grossAmount,
    this.appointmentSample,
    this.doctorSample,
    this.receiptSample,
    this.patientSample,
    this.receptionistId,
  });

  factory InvoiceSample.fromJson(Map<String, dynamic> json) {
    return InvoiceSample(
      id: json['id'],
      appointmentId: json['appointmentId'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      receptionistId: json['receptionistId'],
      date: json['date'],
      checkupType: json['checkupType'],
      checkupFee: json['checkupFee'],
      paymentType: json['paymentType'],
      disposibles: json['disposibles'],
      grossAmount: json['grossAmount'],
      appointmentSample: json['appointment'] != null
          ? AppointmentSample.fromJson(json['appointment'])
          : null,
      doctorSample:
      json['doctor'] != null ? DoctorSample.fromJson(json['doctor']) : null,
      patientSample: json['patient'] != null
          ? new PatientSample.fromJson(json['patient'])
          : null,
      receiptSample: json['receipt'] != null
          ? new ReceiptSample.fromJson(json['receipt'])
          : null,
    );
  }
}
