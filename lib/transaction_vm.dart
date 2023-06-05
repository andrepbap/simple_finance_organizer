import 'package:simple_finance_organizer/screen_state.dart';
import 'package:simple_finance_organizer/transaction_repository.dart';

class TransactionVM {
  late ScreenState state;
  late Function setState;

  static TransactionVM createWith(ScreenState state, Function setState) {
    var vm = TransactionVM();
    vm.state = state;
    vm.setState = setState;
    return vm;
  }

  void getTransactions() async {
    var transactions = await TransactionRepository().get();

    setState(() {
      state.success = transactions;
    });
  }
}
