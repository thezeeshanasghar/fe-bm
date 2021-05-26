import 'package:flutter/foundation.dart';
class Invoice {
  final int id;
  final String InvoiceType;
  final String UserId;
  final String FirstName;
  final String LastName;
  final String Doctor;
  final String AppointmentType;
  final DateTime DateTo;
  final DateTime DateFrom;
  final DateTime AppointmentDate;
  final double Charges;

  Invoice({
    this.id,
    @required this.InvoiceType,
    @required this.UserId,
    @required this.AppointmentDate,
    @required this.Charges,
    @required this.FirstName,
    @required this.LastName,
    @required this.Doctor,
    @required this.AppointmentType,
    @required this.DateTo,
    @required this.DateFrom,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      InvoiceType: json['InvoiceType'],
      UserId: json['UserId'],
      AppointmentDate: json['AppointmentDate'],
      Charges: json['Charges'],
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      Doctor: json['Doctor'],
      AppointmentType: json['AppointmentType'],
      DateTo: json['DateTo'],
      DateFrom: json['DateFrom'],
    );
  }
}
