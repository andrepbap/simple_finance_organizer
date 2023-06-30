import 'package:simple_finance_organizer/dao/bank_account_dao.dart';
import 'package:simple_finance_organizer/infra/http_client.dart';
import 'package:simple_finance_organizer/infra/firestore_client.dart';
import 'package:simple_finance_organizer/model/bank_account_list_model.dart';
import 'package:simple_finance_organizer/model/bank_account_model.dart';

class BankAccountDAOImpl implements BankAccountnDAO {
  final entity = "bank_account";
  final HttpClient client;

  factory BankAccountDAOImpl() {
    return BankAccountDAOImpl._internal(HttpClientImpl());
  }

  BankAccountDAOImpl._internal(this.client);

  @override
  void create({required BankAccountModel account}) {
    client.post(
        object: account.toMap(), toEntity: entity, withKey: account.name);
  }

  @override
  Future<BankAccountListModel> getAll() async {
    var mapArray = await client.getAll(from: entity);
    return BankAccountListModel.fromMap(mapArray);
  }
}
