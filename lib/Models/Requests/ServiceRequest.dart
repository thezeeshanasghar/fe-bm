class ServiceRequest {
  int id;
  String name;
  String description;

  ServiceRequest({this.id = -1, this.name, this.description});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    return data;
  }
}
