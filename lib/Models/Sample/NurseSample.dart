import 'package:baby_doctor/Models/Sample/UserSample.dart';

class NurseSample {
  final int id;
  final int userId;

  final int dutyDuration;
  final int sharePercentage;
  final double salary;

  final UserSample user;

  NurseSample({
    this.id,
    this.userId,
    this.dutyDuration,
    this.sharePercentage,
    this.salary,
    this.user,
  });

  factory NurseSample.fromJson(Map<String, dynamic> json) {
    return NurseSample(
      id: json['id'],
      userId: json['userId'],
      dutyDuration: json['dutyDuration'],
      sharePercentage: json['sharePercentage'],
      salary: json['salary'],
      user: json['user'],
    );
  }
}
