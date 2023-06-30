import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/bank_account_list_model.dart';
import 'package:simple_finance_organizer/repository/bank_account_repository.dart';
import 'package:simple_finance_organizer/ui/state/screen_state.dart';

class BankAccountVM {
  late BankAccountNotifier _vn;

  final BankAccountRepository _accountRepository;

  factory BankAccountVM() {
    return BankAccountVM._internal(BankAccountRepository());
  }

  BankAccountVM._internal(this._accountRepository) {
    _vn = BankAccountNotifier();
  }

  BankAccountNotifier observe() {
    return _vn;
  }

  void getBankAccounts() async {
    var result = await _accountRepository.getAll();
    _vn.update(ScreenState<BankAccountListModel>(success: result));
  }

  void dispose() {
    _vn.dispose();
  }
}

class BankAccountNotifier
    extends ValueNotifier<ScreenState<BankAccountListModel>> {
  BankAccountNotifier({ScreenState<BankAccountListModel>? value})
      : super(value ?? ScreenState<BankAccountListModel>());

  void update(ScreenState<BankAccountListModel> value) {
    this.value = value;
  }
}
