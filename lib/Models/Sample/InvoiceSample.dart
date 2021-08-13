class InvoiceSample {
  final int id;
  final int appointmentId;
  final int doctorId;
  final int patientId;

  final DateTime date;
  final String checkupType;
  final double checkupFee;
  final String paymentType;
  final double disposibles;
  final double grossAmount;

  InvoiceSample({
    this.id,
    this.appointmentId,
    this.doctorId,
    this.patientId,
    this.date,
    this.checkupType,
    this.checkupFee,
    this.paymentType,
    this.disposibles,
    this.grossAmount,
  });

  factory InvoiceSample.fromJson(Map<String, dynamic> json) {
    return InvoiceSample(
      id: json['id'],
      appointmentId: json['appointmentId'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      date: json['date'],
      checkupType: json['checkupType'],
      checkupFee: json['checkupFee'],
      paymentType: json['paymentType'],
      disposibles: json['disposibles'],
      grossAmount: json['grossAmount'],
    );
  }
}
