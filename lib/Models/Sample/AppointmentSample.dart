class AppointmentSample {
  final int id;
  final int patientId;
  final int doctorId;
  final String code;
  final String date;
  final String consultationDate;
  final String type;

  AppointmentSample({
    this.id,
    this.patientId,
    this.doctorId,
    this.code,
    this.date,
    this.consultationDate,
    this.type,
  });

  factory AppointmentSample.fromJson(Map<String, dynamic> json) {
    return AppointmentSample(
      id: json['id'],
      patientId: json['patientId'],
      doctorId: json['doctorId'],
      code: json['code'],
      date: json['date'],
      consultationDate: json['consultationDate'],
      type: json['type'],
    );
  }
}
