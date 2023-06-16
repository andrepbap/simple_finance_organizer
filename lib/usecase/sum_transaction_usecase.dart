import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/repository/transaction_repository.dart';

class SumTransactionUsecase {
  final TransactionRepository transactionRepository;

  factory SumTransactionUsecase() {
    return SumTransactionUsecase._internal(TransactionRepository());
  }

  SumTransactionUsecase._internal(this.transactionRepository);

  Future<double> sum() async {
    TransactionListModel transactionList = await transactionRepository.getAll();

    return transactionList.transactions
        .map((transaction) => transaction.value)
        .fold(0.0, (previous, actual) => (previous as double) + actual);
  }
}
