class QualificationRequest {
  final int Id;
  final int UserId;

  final String Certificate;
  final String Description;
  final String QualificationType;

  QualificationRequest({
    this.Id,
    this.UserId,
    this.Certificate,
    this.Description,
    this.QualificationType,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "UserId": UserId,
        "Certificate": Certificate,
        "Description": Description,
        "QualificationType": QualificationType,
      };
}
