import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  final String description;
  final double value;
  final Timestamp date;
  final String bankAccountName;

  TransactionModel(
      this.description, this.value, this.date, this.bankAccountName);

  static TransactionModel fromMap(Map<String, dynamic> map) {
    var temp = map["bankAccountName"] ?? "";

    var transaction = TransactionModel(map["description"],
        double.parse(map["value"].toString()), map["date"], temp);
    transaction.id = map["id"];
    return transaction;
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "value": value,
      "date": date,
      "bankAccountName": bankAccountName,
    };
  }
}
