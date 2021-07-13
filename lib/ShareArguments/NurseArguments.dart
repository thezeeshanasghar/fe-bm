import 'package:flutter/cupertino.dart';
class NurseArguments {
  final int id;
  final int DutyDuration;
  final int SharePercentage;
  final int Salary;
  final int employeeId;
  final String employeeType;
  final String firstName;
  final String lastName;
  final String fatherHusbandName;
  final String gender;
  final String CNIC;
  final String contact;
  final String emergencyContact;
  final String experience;
  final int flourNo;
  final String password;
  final String userName;
  final String joiningDate;
  final String address;
  final String email;

  NurseArguments(
      {this.id,
        @required this.DutyDuration,
        @required this.SharePercentage,
        @required this.Salary,
        @required this.employeeType,
        @required this.employeeId,
        @required this.firstName,
        @required this.lastName,
        @required this.fatherHusbandName,
        @required this.gender,
        @required this.CNIC,
        @required this.contact,
        @required this.emergencyContact,
        @required this.experience,
        @required this.flourNo,
        @required this.password,
        @required this.userName,
        @required this.joiningDate,
        @required this.address,
        @required this.email,
        });
}
