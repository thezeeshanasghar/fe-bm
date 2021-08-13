class InvoiceProcedureSample {
  final int id;
  final int userId;
  final int invoiceId;

  InvoiceProcedureSample({
    this.id,
    this.userId,
    this.invoiceId,
  });

  factory InvoiceProcedureSample.fromJson(Map<String, dynamic> json) {
    return InvoiceProcedureSample(
      id: json['id'],
      userId: json['userId'],
      invoiceId: json['invoiceId'],
    );
  }
}
