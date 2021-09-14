class ProcedureRequest {
  final int id;

  final String name;
  final String executant;
  final bool consent;
  final int charges;
  final int executantShare;

  ProcedureRequest({
    this.id = -1,
    this.name,
    this.executant,
    this.consent,
    this.charges,
    this.executantShare,
  });

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Executant": executant,
        "Charges": charges,
        "ExecutantShare": executantShare,
        "Consent": consent,
      };
}
