import 'package:simple_finance_organizer/dao/transaction_dao.dart';
import 'package:simple_finance_organizer/infra/http_client.dart';
import 'package:simple_finance_organizer/infra/http_client_impl.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';

class TransactionDAOImpl implements TransactionDAO {
  final entity = "transaction";
  final HttpClient client;

  factory TransactionDAOImpl() {
    return TransactionDAOImpl._internal(HttpClientImpl());
  }

  TransactionDAOImpl._internal(this.client);

  @override
  void create({required TransactionModel transaction}) {
    client.post(object: transaction.toMap(), to: entity);
  }

  @override
  Future<TransactionListModel> getAll() async {
    var mapArray = await client.getAll(from: entity, orderBy: "date");
    return TransactionListModel.fromMap(mapArray);
  }

  @override
  Future<TransactionModel> get() async {
    var map = await client.get(from: entity);
    return TransactionModel.fromMap(map);
  }
}
