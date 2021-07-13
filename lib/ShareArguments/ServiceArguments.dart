import 'package:flutter/foundation.dart';

class ServiceArguments {
  final int id;
  final String name;
  final String description;

  ServiceArguments({
    this.id,
    @required this.name,
    @required this.description,
  });
}
