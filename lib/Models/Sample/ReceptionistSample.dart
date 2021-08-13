import 'package:baby_doctor/Models/Sample/UserSample.dart';

class ReceptionistSample {
  final int id;
  final int userId;

  final String jobType;
  final String shiftTime;

  final UserSample userSample;

  ReceptionistSample({
    this.id,
    this.userId,
    this.jobType,
    this.shiftTime,
    this.userSample,
  });

  factory ReceptionistSample.fromJson(Map<String, dynamic> json) {
    return ReceptionistSample(
      id: json['id'],
      userId: json['userId'],
      jobType: json['jobType'],
      shiftTime: json['shiftTime'],
    );
  }
}
