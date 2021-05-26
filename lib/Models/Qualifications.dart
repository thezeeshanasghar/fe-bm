import 'package:flutter/foundation.dart';
class Qualifications {
  final int id;
  final String employeeId;
  final String certificate;
  final String description;
  final String qualificationType;

  Qualifications({
    this.id,
    this.employeeId,
    @required this.certificate,
    @required this.description,
    @required this.qualificationType,

  });

  factory Qualifications.fromJson(Map<String, dynamic> json) {
    return Qualifications(
      id: json['id'],
      employeeId: json['employeeId'],
      certificate: json['certificate'],
      description: json['description'],
      qualificationType: json['qualificationType'],
    );
  }
}
