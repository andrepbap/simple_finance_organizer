import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String description;
  final double value;
  final Timestamp date;

  TransactionModel(this.description, this.value, this.date);

  static TransactionModel fromMap(Map<String, dynamic> map) {
    return TransactionModel(map["description"], map["value"], map["date"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "description": description,
      "value": value,
      "date": date,
    };
  }
}
