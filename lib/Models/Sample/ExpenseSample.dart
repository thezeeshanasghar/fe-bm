class ExpenseSample {
  final int id;

  final String billType;
  final String paymentType;
  final String employeeOrVender;
  final String voucherNo;
  final String expenseCategory;
  final String employeeName;
  final double totalBill;
  final String transactionDetail;

  ExpenseSample({
    this.id,
    this.billType,
    this.paymentType,
    this.employeeOrVender,
    this.voucherNo,
    this.expenseCategory,
    this.employeeName,
    this.totalBill,
    this.transactionDetail,
  });

  factory ExpenseSample.fromJson(Map<String, dynamic> json) {
    return ExpenseSample(
      id: json['id'],
      billType: json['billType'],
      paymentType: json['paymentType'],
      employeeOrVender: json['employeeOrVender'],
      voucherNo: json['voucherNo'],
      expenseCategory: json['expenseCategory'],
      employeeName: json['employeeName'],
      totalBill: json['totalBill'],
      transactionDetail: json['transactionDetail'],
    );
  }
}
