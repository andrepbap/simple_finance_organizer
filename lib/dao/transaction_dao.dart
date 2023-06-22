import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';

abstract class TransactionDAO {
  Future<TransactionListModel> getAll();
  Future<TransactionModel> get();
  void create({required TransactionModel transaction});
  void update({required TransactionModel transaction});
  void delete({required String id});
}
