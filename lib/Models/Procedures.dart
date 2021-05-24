import 'package:flutter/foundation.dart';

class Procedures {
  final int id;
  final String name;
  final String performedBy;
  final double charges;
  final double performerShare;

  Procedures(
      {this.id,
      @required this.name,
      @required this.performedBy,
      @required this.charges,
      @required this.performerShare});

  factory Procedures.fromJson(Map<String, dynamic> json) {
    return Procedures(
      id: json['id'],
      name: json['name'],
      performerShare: json['performerShare'],
      performedBy: json['performedBy'],
      charges: json['charges'],
    );
  }
}
