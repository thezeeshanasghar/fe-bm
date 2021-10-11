import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';

class ReceptionistRequest {
  final int id;
  final int userId;

  final String dateOfBirth;
  final String maritalStatus;
  final String religion;
  final String userType;
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
  final int floorNo;
  final String experience;

  final String jobType;
  final String shiftTime;
  final List<QualificationRequest> qualificationList;

  ReceptionistRequest({
    this.id = -1,
    this.userId = -1,
    this.userType = "Receptionist",
    this.dateOfBirth = '1900-01-01',
    this.maritalStatus = "Other",
    this.religion = "Islam",
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
    this.experience = '-1',
    this.jobType = "Part-Time",
    this.shiftTime = '8-12',
    this.qualificationList,
  });

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
    data['JobType'] = this.jobType;
    data['ShiftTime'] = this.shiftTime;
    if (this.qualificationList != null) {
      data['QualificationList'] =
          this.qualificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
