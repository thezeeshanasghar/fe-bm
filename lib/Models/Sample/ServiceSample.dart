class ServiceSample {
  final int id;
  final String name;
  final String description;

  ServiceSample({
    this.id,
    this.name,
    this.description,
  });

  factory ServiceSample.fromJson(Map<String, dynamic> json) {
    return ServiceSample(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
