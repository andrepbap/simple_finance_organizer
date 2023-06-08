import 'package:simple_finance_organizer/transaction_model.dart';

class MockedServer {
  static MockedServer? instance;
  List<TransactionModel> mock = [];

  static MockedServer getInstance() {
    instance ??= MockedServer();

    return instance!;
  }
}
