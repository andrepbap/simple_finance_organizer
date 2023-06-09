import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/screen_state.dart';
import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_repository.dart';

class TransactionVM {
  static final TransactionVM _instance =
      TransactionVM._internal(TransactionRepository());

  late TransactionNotifier _vn;

  final TransactionRepository _repository;

  factory TransactionVM() {
    return _instance;
  }

  TransactionVM._internal(this._repository) {
    _vn = TransactionNotifier();
  }

  TransactionNotifier observe() {
    return _vn;
  }

  void getTransactions() async {
    var result = await _repository.get();
    _vn.update(ScreenState<List<TransactionModel>>(result));
  }

  void createTransaction(String description, double value) {
    _repository
        .post(TransactionModel(description, value, DateTime(2023, 6, 1)));
    getTransactions();
  }

  void dispose() {
    _vn.dispose();
  }
}

class TransactionNotifier
    extends ValueNotifier<ScreenState<List<TransactionModel>>> {
  TransactionNotifier({ScreenState<List<TransactionModel>>? value})
      : super(value ?? ScreenState<List<TransactionModel>>([]));

  void update(ScreenState<List<TransactionModel>> value) {
    this.value = value;
  }
}
