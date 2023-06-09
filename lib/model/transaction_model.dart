class TransactionModel {
  final String description;
  final double value;
  final DateTime date;

  TransactionModel(this.description, this.value, this.date);

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(
        map["description"], map["value"], DateTime(2023, 6, 1));
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "value": value,
      "date": date,
    };
  }
}
