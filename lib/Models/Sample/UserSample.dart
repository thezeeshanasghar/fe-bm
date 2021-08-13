import 'package:baby_doctor/Models/Sample/QualificationSample.dart';

class UserSample {
  final int id;

  final String userType;
  final DateTime dateOfBirth;
  final String maritalStatus;
  final String religion;
  final String firstName;
  final String lastName;
  final String fatherHusbandName;
  final String gender;
  final String cnic;
  final String contact;
  final String emergencyContact;
  final String email;
  final String address;
  final DateTime joiningDate;
  final int floorNo;
  final String experience;

  final List<QualificationSample> qualifications;

  UserSample({
    this.id,
    this.userType,
    this.dateOfBirth,
    this.maritalStatus,
    this.religion,
    this.firstName,
    this.lastName,
    this.fatherHusbandName,
    this.gender,
    this.cnic,
    this.contact,
    this.emergencyContact,
    this.email,
    this.address,
    this.joiningDate,
    this.floorNo,
    this.experience,
    this.qualifications,
  });

  factory UserSample.fromJson(Map<String, dynamic> json) {
    var list = json['qualifications'] as List;
    List<QualificationSample> dataList =
        list.map((i) => QualificationSample.fromJson(i)).toList();

    return UserSample(
      id: json['id'],
      userType: json['userType'],
      dateOfBirth: json['dateOfBirth'],
      maritalStatus: json['maritalStatus'],
      religion: json['religion'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fatherHusbandName: json['fatherHusbandName'],
      gender: json['gender'],
      cnic: json['cnic'],
      contact: json['contact'],
      emergencyContact: json['emergencyContact'],
      email: json['email'],
      address: json['address'],
      joiningDate: json['joiningDate'],
      floorNo: json['floorNo'],
      experience: json['experience'],
      qualifications: dataList,
    );
  }
}
