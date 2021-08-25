import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';

class DoctorRequest {
  int id;
  int userId;

  String userType;
  String dateOfBirth;
  String maritalStatus;
  String religion;
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
  int consultationFee;
  int emergencyConsultationFee;
  int shareInFee;
  String specialityType;
  List<QualificationRequest> qualificationList;

  DoctorRequest(
      {this.id = -1,
      this.userId = -1,
      this.userType,
      this.dateOfBirth = '1900-01-01',
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
      this.joiningDate = '1900-01-01',
      this.floorNo = -1,
      this.experience,
      this.consultationFee = -1,
      this.emergencyConsultationFee = -1,
      this.shareInFee = -1,
      this.specialityType,
      this.qualificationList});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['UserType'] = this.userType;
    data['DateOfBirth'] = this.dateOfBirth;
    data['MaritalStatus'] = this.maritalStatus;
    data['Religion'] = this.religion;
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
    data['ConsultationFee'] = this.consultationFee;
    data['EmergencyConsultationFee'] = this.emergencyConsultationFee;
    data['ShareInFee'] = this.shareInFee;
    data['SpecialityType'] = this.specialityType;
    if (this.qualificationList != null) {
      data['QualificationList'] = this.qualificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
