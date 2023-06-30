import 'package:simple_finance_organizer/dao/transaction_dao.dart';
import 'package:simple_finance_organizer/infra/http_client.dart';
import 'package:simple_finance_organizer/infra/firestore_client.dart';
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
    client.create(object: transaction.toMap(), onEntity: entity);
  }

  @override
  Future<TransactionListModel> getAll() async {
    var mapArray = await client.getAll(fromEntity: entity, orderingBy: "date");
    return TransactionListModel.fromMap(mapArray);
  }

  @override
  Future<TransactionModel> get() async {
    var map = await client.get(from: entity);
    return TransactionModel.fromMap(map);
  }

  @override
  void update({required TransactionModel transaction}) {
    client.update(
        object: transaction.toMap(), inEntity: entity, where: transaction.id!);
  }

  @override
  void delete({required String id}) {
    client.delete(from: entity, where: id);
  }

  @override
  Future<TransactionListModel> getByBankAccount(String accountName) async {
    final query = <String, dynamic>{
      "bankAccountName": accountName,
    };
    final mapFromQuery = Map<String, dynamic>.from(query);

    var result = await client.getAll(
        fromEntity: entity, withQuery: mapFromQuery, orderingBy: "date");

    return TransactionListModel.fromMap(result);
  }
}
