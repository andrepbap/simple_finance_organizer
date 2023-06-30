import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/bank_account_model.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/repository/bank_account_repository.dart';
import 'package:simple_finance_organizer/ui/state/screen_state.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';
import 'package:simple_finance_organizer/repository/transaction_repository.dart';

class TransactionVM {
  late TransactionNotifier _vn;

  final TransactionRepository _transactionRepository;
  final BankAccountRepository _accountRepository;

  factory TransactionVM() {
    return TransactionVM._internal(
        TransactionRepository(), BankAccountRepository());
  }

  TransactionVM._internal(
      this._transactionRepository, this._accountRepository) {
    _vn = TransactionNotifier();
  }

  TransactionNotifier observe() {
    return _vn;
  }

  void getTransactions() async {
    var result = await _transactionRepository.getAll();
    _vn.update(ScreenState<TransactionListModel>(success: result));
  }

  void createTransaction(String description, double value, DateTime date,
      String accountName) async {
    _accountRepository.post(BankAccountModel(accountName, accountName));

    _transactionRepository.post(TransactionModel(
        description, value, Timestamp.fromDate(date), accountName));

    getTransactions();
  }

  void updateTransaction(String id, String description, double value,
      DateTime date, String accountName) {
    _accountRepository.post(BankAccountModel(accountName, accountName));

    var transaction = TransactionModel(
        description, value, Timestamp.fromDate(date), accountName);
    transaction.id = id;

    _transactionRepository.update(transaction);

    getTransactions();
  }

  void deleteTransaction(String id) {
    _transactionRepository.delete(id);
    getTransactions();
  }

  void dispose() {
    _vn.dispose();
  }
}

class TransactionNotifier
    extends ValueNotifier<ScreenState<TransactionListModel>> {
  TransactionNotifier({ScreenState<TransactionListModel>? value})
      : super(value ?? ScreenState<TransactionListModel>());

  void update(ScreenState<TransactionListModel> value) {
    this.value = value;
  }
}
