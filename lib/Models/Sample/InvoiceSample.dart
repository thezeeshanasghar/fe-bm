import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';
import 'package:baby_doctor/Models/Sample/DoctorSample.dart';

class InvoiceSample {
  final int id;
  final int appointmentId;
  final int doctorId;
  final int patientId;

  final DateTime date;
  final String checkupType;
  final double checkupFee;
  final String paymentType;
  final double disposibles;
  final double grossAmount;

  final AppointmentSample appointment;
  final DoctorSample doctor;

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
    this.appointment,
    this.doctor,
  });

  factory InvoiceSample.fromJson(Map<String, dynamic> json) {
    return InvoiceSample(
      id: json['id'],
      appointmentId: json['appointmentId'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      date: json['date'],
      checkupType: json['checkupType'],
      checkupFee: json['checkupFee'],
      paymentType: json['paymentType'],
      disposibles: json['disposibles'],
      grossAmount: json['grossAmount'],
      appointment: json['appointment'],
      doctor: json['doctor'],
    );
  }
}
