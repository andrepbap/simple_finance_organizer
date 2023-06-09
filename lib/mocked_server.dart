import 'package:simple_finance_organizer/model/transaction_model.dart';

class MockedServer {
  static final MockedServer _instance = MockedServer._internal();

  List<TransactionModel> mock = [];

  factory MockedServer() {
    return _instance;
  }

  MockedServer._internal();
}
