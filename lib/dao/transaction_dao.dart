import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';

abstract class TransactionDAO {
  Future<TransactionListModel> getAll();
  void create({required TransactionModel transaction});
}
