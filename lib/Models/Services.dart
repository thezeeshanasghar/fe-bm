import 'package:flutter/foundation.dart';
class Services {
  final int id;
  final String name;
  final String description;


  Services({
    this.id,
    @required this.name,
    @required this.description,

  });

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      id: json['id'],
      name: json['name'],
      description: json['description'],

    );
  }
}
