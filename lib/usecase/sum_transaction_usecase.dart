import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/repository/transaction_repository.dart';

class SumTransactionUsecase {
  final TransactionRepository _transactionRepository;

  factory SumTransactionUsecase() {
    return SumTransactionUsecase._internal(TransactionRepository());
  }

  SumTransactionUsecase._internal(this._transactionRepository);

  Future<double> sum({String? account}) async {
    TransactionListModel transactionList = account != null
        ? await _transactionRepository.getByBankAccount(account)
        : await _transactionRepository.getAll();

    return transactionList.transactions
        .map((transaction) => transaction.value)
        .fold(0.0, (previous, actual) => (previous as double) + actual);
  }
}
