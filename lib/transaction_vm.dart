import 'package:simple_finance_organizer/screen_state.dart';
import 'package:simple_finance_organizer/transaction_repository.dart';

class TransactionVM {
  static TransactionVM? instance;
  late ScreenState _state;
  late Function _setState;

  static TransactionVM createWith(ScreenState state, Function setState) {
    if (instance == null) {
      instance = TransactionVM();
      instance!._state = state;
      instance!._setState = setState;
    }

    return instance!;
  }

  void getTransactions() async {
    var transactions = await TransactionRepository().get();

    _setState(() {
      _state.success = transactions;
    });
  }
}
