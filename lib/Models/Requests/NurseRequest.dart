import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';

class NurseRequest {
  final int Id;
  final int UserId;

  final DateTime DateOfBirth;
  final String MaritalStatus;
  final String Religion;
  final String UserType;
  final String FirstName;
  final String LastName;
  final String FatherHusbandName;
  final String Gender;
  final String Cnic;
  final String Contact;
  final String EmergencyContact;
  final String Email;
  final String Address;
  final DateTime JoiningDate;
  final int FloorNo;
  final String Experience;

  final int DutyDuration;
  final int SharePercentage;
  final int Salary;
  final List<QualificationRequest> QualificationList;

  NurseRequest({
    this.Id,
    this.UserId,
    this.UserType,
    this.DateOfBirth,
    this.MaritalStatus,
    this.Religion,
    this.FirstName,
    this.LastName,
    this.FatherHusbandName,
    this.Gender,
    this.Cnic,
    this.Contact,
    this.EmergencyContact,
    this.Email,
    this.Address,
    this.JoiningDate,
    this.FloorNo,
    this.Experience,
    this.DutyDuration,
    this.SharePercentage,
    this.Salary,
    this.QualificationList,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "UserId": UserId,
        "UserType": UserType,
        "DateOfBirth": DateOfBirth,
        "MaritalStatus": MaritalStatus,
        "Religion": Religion,
        "FirstName": FirstName,
        "LastName": LastName,
        "FatherHusbandName": FatherHusbandName,
        "Gender": Gender,
        "Cnic": Cnic,
        "Contact": Contact,
        "EmergencyContact": EmergencyContact,
        "Email": Email,
        "Address": Address,
        "JoiningDate": JoiningDate,
        "FloorNo": FloorNo,
        "Experience": Experience,
        "DutyDuration": DutyDuration,
        "SharePercentage": SharePercentage,
        "Salary": Salary,
        "QualificationList": QualificationList,
      };
}
