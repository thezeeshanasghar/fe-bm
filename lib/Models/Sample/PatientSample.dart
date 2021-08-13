import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';
import 'package:baby_doctor/Models/Sample/UserSample.dart';

class PatientSample {
  final int id;
  final String userId;

  final String category;
  final String birthPlace;
  final String type;
  final String externalId;
  final String bloodGroup;
  final String clinicSite;
  final String referredBy;
  final DateTime referredDate;
  final String guardian;
  final String paymentProfile;
  final String description;

  final List<AppointmentSample> appointments;
  final UserSample user;

  PatientSample(
      {this.id,
      this.userId,
      this.category,
      this.birthPlace,
      this.type,
      this.externalId,
      this.bloodGroup,
      this.clinicSite,
      this.referredBy,
      this.referredDate,
      this.guardian,
      this.paymentProfile,
      this.description,
      this.appointments,
      this.user});

  factory PatientSample.fromJson(Map<String, dynamic> json) {
    var list = json['appointments'] as List;
    List<AppointmentSample> dataList =
        list.map((i) => AppointmentSample.fromJson(i)).toList();

    return PatientSample(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      birthPlace: json['birthPlace'],
      type: json['type'],
      externalId: json['externalId'],
      bloodGroup: json['bloodGroup'],
      clinicSite: json['clinicSite'],
      referredBy: json['referredBy'],
      referredDate: json['referredDate'],
      guardian: json['guardian'],
      paymentProfile: json['paymentProfile'],
      description: json['description'],
      appointments: dataList,
      user: json['user'],
    );
  }
}
