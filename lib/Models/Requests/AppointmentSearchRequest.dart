class AppointmentSearchRequest {
  String search;
  String category;
  String doctor;
  String dateFrom;
  String dateTo;
  String booked;
  String searchFrom;

  AppointmentSearchRequest(
      {this.search,
      this.category,
      this.doctor = '-1',
      this.dateFrom = '1900-09-09',
      this.dateTo = '2021-09-09',
      this.booked = '-1',
      this.searchFrom});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Search'] = this.search;
    data['Category'] = this.category;
    data['Doctor'] = this.doctor;
    data['DateFrom'] = this.dateFrom;
    data['DateTo'] = this.dateTo;
    data['Booked'] = this.booked;
    data['searchFrom'] = this.searchFrom;
    return data;
  }
}
