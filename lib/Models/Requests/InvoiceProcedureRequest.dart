class InvoiceProcedureRequest {
  final int Id;
  final int ProcedureId;
  final int InvoiceId;

  InvoiceProcedureRequest({
    this.Id,
    this.ProcedureId,
    this.InvoiceId,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "ProcedureId": ProcedureId,
        "InvoiceId": InvoiceId,
      };
}
