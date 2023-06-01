import 'package:simple_finance_organizer/transaction_model.dart';

class TransactionRepository {
  Future<List<TransactionModel>> get() async {
    return [
      TransactionModel("Coxinha", 5.90, DateTime(2023, 6, 1)),
      TransactionModel("Robô Aspirador", 1400, DateTime(2023, 5, 25))
    ];
  }
}
