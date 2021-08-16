class PatientRequest {
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

  final String Category;
  final String BirthPlace;
  final String Type;
  final String ExternalId;
  final String BloodGroup;
  final String ClinicSite;
  final String ReferredBy;
  final DateTime ReferredDate;
  final String Guardian;
  final String PaymentProfile;
  final String Description;

  final String AppointmentCode;
  final DateTime ConsultationDate;
  final String AppointmentType;

  PatientRequest({
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
    this.Category,
    this.BirthPlace,
    this.Type,
    this.ExternalId,
    this.BloodGroup,
    this.ClinicSite,
    this.ReferredBy,
    this.ReferredDate,
    this.Guardian,
    this.PaymentProfile,
    this.Description,
    this.AppointmentCode,
    this.ConsultationDate,
    this.AppointmentType,
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
        "Category": Category,
        "BirthPlace": BirthPlace,
        "Type": Type,
        "ExternalId": ExternalId,
        "BloodGroup": BloodGroup,
        "ClinicSite": ClinicSite,
        "ReferredBy": ReferredBy,
        "ReferredDate": ReferredDate,
        "Guardian": Guardian,
        "PaymentProfile": PaymentProfile,
        "Description": Description,
        "AppointmentCode": AppointmentCode,
        "ConsultationDate": ConsultationDate,
        "AppointmentType": AppointmentType,
      };
}
