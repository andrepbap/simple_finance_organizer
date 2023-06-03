import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_repository.dart';

class TransactionVM {
  late TransactionState state;

  void getTransactions(Function setState) async {
    var transactions = await TransactionRepository().get();

    setState(() {
      state.success = transactions;
    });
  }
}

class TransactionState {
  List<TransactionModel> success;

  TransactionState(this.success);
}
