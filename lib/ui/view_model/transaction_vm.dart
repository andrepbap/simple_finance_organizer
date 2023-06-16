import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/ui/state/screen_state.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';
import 'package:simple_finance_organizer/repository/transaction_repository.dart';

class TransactionVM {
  late TransactionNotifier _vn;

  final TransactionRepository _repository;

  factory TransactionVM() {
    return TransactionVM._internal(TransactionRepository());
  }

  TransactionVM._internal(this._repository) {
    _vn = TransactionNotifier();
  }

  TransactionNotifier observe() {
    return _vn;
  }

  void getTransactions() async {
    var result = await _repository.getAll();
    _vn.update(ScreenState<TransactionListModel>(success: result));
  }

  void createTransaction(String description, double value, DateTime date) {
    _repository
        .post(TransactionModel(description, value, Timestamp.fromDate(date)));
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
