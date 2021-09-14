class ProcedureSample {
  final int id;
  final String name;
  final bool consent;
  final String executant;
  final int charges;
  final int executantShare;

  ProcedureSample({
    this.id,
    this.name,
    this.executant,
    this.consent,
    this.charges,
    this.executantShare,
  });

  factory ProcedureSample.fromJson(Map<String, dynamic> json) {
    return ProcedureSample(
      id: json['id'],
      name: json['name'],
      executant: json['executant'],
      consent: json['consent'],
      charges: json['charges'],
      executantShare: json['executantShare'],
    );
  }
}
