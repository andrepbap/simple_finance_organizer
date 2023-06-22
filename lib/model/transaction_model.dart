import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? id;
  final String description;
  final double value;
  final Timestamp date;

  TransactionModel(this.description, this.value, this.date);

  static TransactionModel fromMap(Map<String, dynamic> map) {
    var transaction =
        TransactionModel(map["description"], map["value"], map["date"]);
    transaction.id = map["id"];
    return transaction;
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "value": value,
      "date": date,
    };
  }
}
