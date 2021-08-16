class DoctorRequest {
  final int Id;
  final int UserId;

  final String UserType;
  final DateTime DateOfBirth;
  final String MaritalStatus;
  final String Religion;
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

  final int ConsultationFee;
  final int EmergencyConsultationFee;
  final int ShareInFee;
  final String SpecialityType;

  DoctorRequest({
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
    this.ConsultationFee,
    this.EmergencyConsultationFee,
    this.ShareInFee,
    this.SpecialityType,
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
        "ConsultationFee": ConsultationFee,
        "EmergencyConsultationFee": EmergencyConsultationFee,
        "ShareInFee": ShareInFee,
        "SpecialityType": SpecialityType,
      };
}
