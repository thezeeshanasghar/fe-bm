import 'package:baby_doctor/Models/Requests/InvoiceProcedureRequest.dart';

class InvoiceRequest {
  final int Id;
  final int AppointmentId;
  final int DoctorId;
  final int PatientId;
  final int ReceptionistId;

  final DateTime Date;
  final String CheckupType;
  final double CheckupFee;
  final String PaymentType;
  final double Disposibles;
  final double GrossAmount;

  final String Pmid;
  final double Discount;
  final int TotalAmount;
  final int PendingAmount;
  final int PaidAmount;

  final List<InvoiceProcedureRequest> procedureList;

  InvoiceRequest(
      {this.Id,
      this.AppointmentId,
      this.DoctorId,
      this.PatientId,
      this.ReceptionistId,
      this.Date,
      this.CheckupType,
      this.CheckupFee,
      this.PaymentType,
      this.Disposibles,
      this.GrossAmount,
      this.Pmid,
      this.Discount,
      this.TotalAmount,
      this.PendingAmount,
      this.PaidAmount,
      this.procedureList});

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "AppointmentId": AppointmentId,
        "DoctorId": DoctorId,
        "PatientId": PatientId,
        "ReceptionistId": ReceptionistId,
        "Date": Date,
        "CheckupType": CheckupType,
        "CheckupFee": CheckupFee,
        "PaymentType": PaymentType,
        "Disposibles": Disposibles,
        "GrossAmount": GrossAmount,
        "Pmid": Pmid,
        "Discount": Discount,
        "TotalAmount": TotalAmount,
        "PendingAmount": PendingAmount,
        "PaidAmount": PaidAmount,
        "procedureList": procedureList,
      };
}
