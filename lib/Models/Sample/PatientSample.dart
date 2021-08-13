class PatientSample {
  final int id;
  final String userId;

  final String category;
  final String birthPlace;
  final String type;
  final String externalId;
  final String bloodGroup;
  final String clinicSite;
  final String referredBy;
  final DateTime referredDate;
  final String guardian;
  final String paymentProfile;
  final String description;

  PatientSample({
    this.id,
    this.userId,
    this.category,
    this.birthPlace,
    this.type,
    this.externalId,
    this.bloodGroup,
    this.clinicSite,
    this.referredBy,
    this.referredDate,
    this.guardian,
    this.paymentProfile,
    this.description,
  });

  factory PatientSample.fromJson(Map<String, dynamic> json) {
    return PatientSample(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      birthPlace: json['birthPlace'],
      type: json['type'],
      externalId: json['externalId'],
      bloodGroup: json['bloodGroup'],
      clinicSite: json['clinicSite'],
      referredBy: json['referredBy'],
      referredDate: json['referredDate'],
      guardian: json['guardian'],
      paymentProfile: json['paymentProfile'],
      description: json['description'],
    );
  }
}
