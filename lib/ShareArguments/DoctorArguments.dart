import 'package:flutter/cupertino.dart';

class DoctorArguments {
  final int id;
  final int ConsultationFee;
  final int EmergencyConsultationFee;
  final int ShareInFee;
  final String SpecialityType;
  final int employeeId;
  final String employeeType;
  final String firstName;
  final String lastName;
  final String fatherHusbandName;
  final String gender;
  final String CNIC;
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

  DoctorArguments(
      {this.id,
      this.ConsultationFee,
      this.EmergencyConsultationFee,
      this.ShareInFee,
      this.SpecialityType,
      this.employeeId,
      this.employeeType,
      this.firstName,
      this.lastName,
      this.fatherHusbandName,
      this.gender,
      this.CNIC,
      this.contact,
      this.emergencyContact,
      this.email,
      this.address,
      this.joiningDate,
      this.userName,
      this.password,
      this.flourNo,
      this.experience,
      this.qualifications});
}
