import 'package:simple_finance_organizer/dao/transaction_dao.dart';
import 'package:simple_finance_organizer/dao/transaction_dao_impl.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';

class TransactionRepository {
  final TransactionDAO dao;
  List<TransactionModel> mock = [];

  factory TransactionRepository() {
    return TransactionRepository._internal(TransactionDAOImpl());
  }

  TransactionRepository._internal(this.dao);

  Future<TransactionListModel> getAll() async {
    return dao.getAll();
  }

  Future<TransactionListModel> getByBankAccount(String accountName) async {
    return dao.getByBankAccount(accountName);
  }

  void post(TransactionModel transaction) async {
    dao.create(transaction: transaction);
  }

  void update(TransactionModel transaction) async {
    dao.update(transaction: transaction);
  }

  void delete(String id) {
    dao.delete(id: id);
  }
}
