import 'package:simple_finance_organizer/model/bank_account_list_model.dart';
import 'package:simple_finance_organizer/model/bank_account_model.dart';

abstract class BankAccountnDAO {
  Future<BankAccountListModel> getAll();
  void create({required BankAccountModel account});
}
