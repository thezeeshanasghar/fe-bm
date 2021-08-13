import 'package:baby_doctor/Models/Sample/UserSample.dart';

class DoctorSample {
  final int id;
  final int userId;

  final int consultationFee;
  final int emergencyConsultationFee;
  final int shareInFee;
  final String specialityType;

  final UserSample user;

  DoctorSample({
    this.id,
    this.userId,
    this.consultationFee,
    this.emergencyConsultationFee,
    this.shareInFee,
    this.specialityType,
    this.user,
  });

  factory DoctorSample.fromJson(Map<String, dynamic> json) {
    return DoctorSample(
      id: json['id'],
      userId: json['userId'],
      consultationFee: json['consultationFee'],
      emergencyConsultationFee: json['emergencyConsultationFee'],
      shareInFee: json['shareInFee'],
      specialityType: json['specialityType'],
      user: json['user'],
    );
  }
}
