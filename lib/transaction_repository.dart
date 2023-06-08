import 'package:simple_finance_organizer/mocked_server.dart';
import 'package:simple_finance_organizer/transaction_model.dart';

class TransactionRepository {
  List<TransactionModel> mock = [];

  Future<List<TransactionModel>> get() async {
    return MockedServer.getInstance().mock;
  }

  void post(TransactionModel transaction) async {
    MockedServer.getInstance().mock.add(transaction);
  }
}
