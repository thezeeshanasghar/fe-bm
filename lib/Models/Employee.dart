import 'package:flutter/foundation.dart';
import 'package:baby_doctor/Models/Qualifications.dart';

class Employee {
  final bool isSuccess;
  final String message;
  final List<EmployeeData> data;

  Employee({
    @required this.isSuccess,
    @required this.message,
    @required this.data,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<EmployeeData> dataList =
    list.map((i) => EmployeeData.fromJson(i)).toList();
    return Employee(
        isSuccess: json['isSuccess'], message: json['message'], data: dataList);
  }
}


class EmployeeData {
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
  final String address;
  final String email;
  final List<dynamic> qualifications;

  EmployeeData(
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
      this.qualifications});

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
        id: json['id'],
        employeeType: json['employeeType'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        fatherHusbandName: json['fatherHusbandName'],
        gender: json['gender'],
        CNIC: json['cnic'],
        contact: json['contact'],
        emergencyContact: json['emergencyContact'],
        experience: json['experience'],
        flourNo: json['flourNo'],
        password: json['password'],
        userName: json['userName'],
        joiningDate: json['joiningDate'],
        address: json['address'],
        email: json['email'],
        qualifications: json['qualifications']);
  }

  Map<String, dynamic> toJson() => {
        "employeeType": employeeType,
        "firstName": firstName,
        "lastName": lastName,
        "fatherHusbandName": fatherHusbandName,
        "gender": gender,
        "cnic": CNIC,
        "contact": contact,
        "emergencyContact": emergencyContact,
        "experience": experience,
        "flourNo": flourNo,
        "password": password,
        "userName": userName,
        "joiningDate": joiningDate,
        "address": address,
        "email": email,
        "qualifications": qualifications,
      };
}
