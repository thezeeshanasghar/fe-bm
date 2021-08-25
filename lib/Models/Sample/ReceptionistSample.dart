import 'package:baby_doctor/Models/Sample/UserSample.dart';

class ReceptionistSample {
  final int id;
  final int userId;

  final String jobType;
  final String shiftTime;

  final UserSample user;

  ReceptionistSample({
    this.id,
    this.userId,
    this.jobType,
    this.shiftTime,
    this.user,
  });

  factory ReceptionistSample.fromJson(Map<String, dynamic> json) {
    return ReceptionistSample(
      id: json['id'],
      userId: json['userId'],
      jobType: json['jobType'],
      shiftTime: json['shiftTime'],
      user: json['user'] != null ? UserSample.fromJson(json['user']) : null,
    );
  }
}
