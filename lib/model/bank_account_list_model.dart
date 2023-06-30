import 'package:simple_finance_organizer/model/bank_account_model.dart';

class BankAccountListModel {
  final List<BankAccountModel> accounts;

  BankAccountListModel(this.accounts);

  static BankAccountListModel fromMap(List<Map<String, dynamic>> mapArray) {
    List<BankAccountModel> accounts = [];
    for (var map in mapArray) {
      accounts.add(BankAccountModel.fromMap(map));
    }
    return BankAccountListModel(accounts);
  }
}
