import 'package:simple_finance_organizer/model/transaction_model.dart';

class TransactionListModel {
  final List<TransactionModel> transactions;

  TransactionListModel(this.transactions);

  static TransactionListModel fromMap(List<Map<String, dynamic>> mapArray) {
    List<TransactionModel> transactions = [];
    for (var map in mapArray) {
      transactions.add(TransactionModel.fromMap(map));
    }
    return TransactionListModel(transactions);
  }
}
