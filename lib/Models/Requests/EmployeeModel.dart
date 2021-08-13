import 'package:flutter/foundation.dart';

class NurseModel {
  final int id;
  final int employeeId;
  final int dutyDuration;
  final int sharePercentage;
  final int salary;
  final EmployeeModelDetails employeeModelDetails;

  NurseModel(
    this.id,
    this.employeeId,
    this.dutyDuration,
    this.sharePercentage,
    this.salary,
    this.employeeModelDetails,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeId": employeeId,
        "dutyDuration": dutyDuration,
        "sharePercentage": sharePercentage,
        "salary": salary,
        "employee": employeeModelDetails,
      };
}

class DoctorModel {
  final int id;
  final int employeeId;
  final int consultationFee;
  final int emergencyConsultationFee;
  final int shareInFee;
  final String specialityType;
  final EmployeeModelDetails employeeModelDetails;

  DoctorModel(
      this.id,
      this.employeeId,
      this.consultationFee,
      this.emergencyConsultationFee,
      this.shareInFee,
      this.specialityType,
      this.employeeModelDetails,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeId": employeeId,
    "consultationFee": consultationFee,
    "emergencyConsultationFee": emergencyConsultationFee,
    "shareInFee": shareInFee,
    "specialityType": specialityType,
    "employee": employeeModelDetails,
  };
}

class EmployeeModelDetails {
  final int id;
  final String employeeType;
  final String firstName;
  final String lastName;
  final String fatherHusbandName;
  final String gender;
  final String cnic;
  final String contact;
  final String emergencyContact;
  final String email;
  final String address;
  final String joiningDate;
  final String userName;
  final String password;
  final int flourNo;
  final String experience;
  final List<String> qualifications;

  EmployeeModelDetails(
      this.id,
      this.employeeType,
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
      this.userName,
      this.password,
      this.flourNo,
      this.experience,
      this.qualifications);

  Map<String, dynamic> toJson() => {
        "id": id,
        "employeeType": employeeType,
        "firstName": firstName,
        "lastName": lastName,
        "fatherHusbandName": fatherHusbandName,
        "gender": gender,
        "cnic": cnic,
        "contact": contact,
        "emergencyContact": emergencyContact,
        "email": email,
        "address": address,
        "joiningDate": joiningDate,
        "userName": userName,
        "password": password,
        "flourNo": flourNo,
        "experience": experience,
        "qualifications": qualifications,
      };

}
