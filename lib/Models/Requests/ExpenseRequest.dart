class ExpenseRequest {
  final int Id;

  final String BillType;
  final String PaymentType;
  final String EmployeeOrVender;
  final String VoucherNo;
  final String ExpenseCategory;
  final String EmployeeName;
  final double TotalBill;
  final String TransactionDetail;

  ExpenseRequest({
    this.Id,
    this.BillType,
    this.PaymentType,
    this.EmployeeOrVender,
    this.VoucherNo,
    this.ExpenseCategory,
    this.EmployeeName,
    this.TotalBill,
    this.TransactionDetail,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "BillType": BillType,
        "PaymentType": PaymentType,
        "EmployeeOrVender": EmployeeOrVender,
        "VoucherNo": VoucherNo,
        "ExpenseCategory": ExpenseCategory,
        "EmployeeName": EmployeeName,
        "TotalBill": TotalBill,
        "TransactionDetail": TransactionDetail,
      };
}
