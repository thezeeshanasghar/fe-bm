import 'package:baby_doctor/Models/Sample/UserSample.dart';

class QualificationSample {
  final int id;
  final int userId;

  final String certificate;
  final String description;
  final String qualificationType;

  final UserSample user;

  QualificationSample({
    this.id,
    this.userId,
    this.certificate,
    this.description,
    this.qualificationType,
    this.user,
  });

  factory QualificationSample.fromJson(Map<String, dynamic> json) {
    return QualificationSample(
      id: json['id'],
      userId: json['userId'],
      certificate: json['certificate'],
      description: json['description'],
      qualificationType: json['qualificationType'],
      user: json['user'],
    );
  }
}
