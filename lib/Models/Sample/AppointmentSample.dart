import 'package:baby_doctor/Models/Sample/PatientSample.dart';
import 'package:baby_doctor/Models/Sample/UserSample.dart';

class AppointmentSample {
  final int id;
  final int patientId;
  final int doctorId;
  final int receptionistId;

  final String code;
  final String date;
  final String consultationDate;
  final String type;
  final String patientCategory;

  final PatientSample patient;

  AppointmentSample({
    this.id,
    this.patientId,
    this.doctorId,
    this.code,
    this.date,
    this.consultationDate,
    this.type,
    this.patient,
    this.patientCategory,
    this.receptionistId,
  });

  factory AppointmentSample.fromJson(Map<String, dynamic> json) {
    return AppointmentSample(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      receptionistId: json['receptionistId'],
      code: json['code'],
      date: json['date'],
      consultationDate: json['consultationDate'],
      type: json['type'],
      patientCategory: json['patientCategory'],
      patient: json['patient'] != null
          ? PatientSample.fromJson(json['patient'])
          : null,
    );
  }
}
