class ProcedureRequest {
  final int Id;

  final String Name;
  final String Executant;
  final int Charges;
  final int ExecutantShare;

  ProcedureRequest({
    this.Id,
    this.Name,
    this.Executant,
    this.Charges,
    this.ExecutantShare,
  });

  Map<String, dynamic> toJson() => {
        "Id": Id,
        "Name": Name,
        "Executant": Executant,
        "Charges": Charges,
        "ExecutantShare": ExecutantShare,
      };
}
