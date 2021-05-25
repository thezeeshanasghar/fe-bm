import 'package:flutter/foundation.dart';
import 'package:baby_doctor/Models/Qualifications.dart';

class Employee {
  final int id;
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
  final String DOB;
  final String address;
  final String email;
  final List<Qualifications> qualifications;

  Employee(
      {this.id,
      @required this.employeeType,
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
        @required this.DOB,
      this.qualifications});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        employeeType: json['name'],
        firstName: json['performerShare'],
        lastName: json['performedBy'],
        fatherHusbandName: json['fatherHusbandName'],
        gender: json['gender'],
        CNIC: json['CNIC'],
        contact: json['contact'],
        emergencyContact: json['emergencyContact'],
        experience: json['experience'],
        flourNo: json['flourNo'],
        password: json['password'],
        userName: json['userName'],
        joiningDate: json['joiningDate'],
        address: json['address'],
        email: json['emails'],
        DOB: json['DOB'],
        qualifications: json['qualifications']);
  }
}
//public virtual ICollection<Qualifications> Qualifications { get; set; }
