import 'package:simple_finance_organizer/dao/bank_account_dao.dart';
import 'package:simple_finance_organizer/dao/bank_account_dao_impl.dart';
import 'package:simple_finance_organizer/model/bank_account_list_model.dart';
import 'package:simple_finance_organizer/model/bank_account_model.dart';

class BankAccountRepository {
  final BankAccountnDAO dao;

  factory BankAccountRepository() {
    return BankAccountRepository._internal(BankAccountDAOImpl());
  }

  BankAccountRepository._internal(this.dao);

  Future<BankAccountListModel> getAll() async {
    return dao.getAll();
  }

  void post(BankAccountModel account) async {
    dao.create(account: account);
  }
}
