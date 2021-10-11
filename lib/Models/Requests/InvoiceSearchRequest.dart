class InvoiceSearchRequest {
  String search;
  String fromDate;
  String toDate;

  InvoiceSearchRequest({
    this.search,
    this.fromDate ,
    this.toDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Search'] = this.search;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    return data;
  }
}
