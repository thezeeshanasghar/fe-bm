import 'package:flutter/foundation.dart';

class ProcedureArguments {
  final int id;
  final String name;
  final String performedBy;
  final double charges;
  final double performerShare;

  ProcedureArguments(
      {this.id,
      @required this.name,
      @required this.performedBy,
      @required this.charges,
      @required this.performerShare});
}
