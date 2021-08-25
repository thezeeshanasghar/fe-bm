import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';
import 'package:baby_doctor/Models/Sample/QualificationSample.dart';

class NurseRequest {
  int id;
  int userId;

  String dateOfBirth;
  String maritalStatus;
  String religion;
  String userType;
  String firstName;
  String lastName;
  String fatherHusbandName;
  String gender;
  String cnic;
  String contact;
  String emergencyContact;
  String email;
  String address;
  String joiningDate;
  int floorNo;
  String experience;
  int dutyDuration;
  int sharePercentage;
  int salary;
  List<QualificationRequest> qualificationList;

  NurseRequest(
      {this.id = -1,
      this.userId = -1,
      this.dateOfBirth = '1900-01-01',
      this.maritalStatus,
      this.religion,
      this.userType,
      this.firstName,
      this.lastName,
      this.fatherHusbandName,
      this.gender,
      this.cnic,
      this.contact,
      this.emergencyContact,
      this.email,
      this.address,
      this.joiningDate = '1900-01-01',
      this.floorNo = -1,
      this.experience,
      this.dutyDuration = -1,
      this.sharePercentage = -1,
      this.salary = -1,
      this.qualificationList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['DateOfBirth'] = this.dateOfBirth;
    data['MaritalStatus'] = this.maritalStatus;
    data['Religion'] = this.religion;
    data['UserType'] = this.userType;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['FatherHusbandName'] = this.fatherHusbandName;
    data['Gender'] = this.gender;
    data['Cnic'] = this.cnic;
    data['Contact'] = this.contact;
    data['EmergencyContact'] = this.emergencyContact;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['JoiningDate'] = this.joiningDate;
    data['FloorNo'] = this.floorNo;
    data['Experience'] = this.experience;
    data['DutyDuration'] = this.dutyDuration;
    data['SharePercentage'] = this.sharePercentage;
    data['Salary'] = this.salary;
    if (this.qualificationList != null) {
      data['QualificationList'] = this.qualificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
