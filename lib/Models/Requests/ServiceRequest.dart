class ServiceRequest {
  final int Id;
  final String Name;
  final String Description;

  ServiceRequest({
    this.Id,
    this.Name,
    this.Description,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Name": Name,
        "Description": Description,
      };
}
