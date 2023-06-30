import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/bank_account_list_model.dart';
import 'package:simple_finance_organizer/model/bank_account_model.dart';
import 'package:simple_finance_organizer/ui/transaction_list_view.dart';
import 'package:simple_finance_organizer/ui/transaction_sum_container.dart';
import 'package:simple_finance_organizer/ui/view_model/bank_account_vm.dart';

// TODO fazer setatefull para criar novo vm para transaction list
class BankAccountListView extends StatelessWidget {
  final BankAccountVM vm;
  final TransactionListView transactionListView;

  BankAccountListView(
      {super.key, required this.vm, required this.transactionListView}) {
    vm.getBankAccounts();
  }

  ListView buildList(BankAccountListModel? accountList, BuildContext context) {
    List<Widget> list = [];

    if (accountList == null) {
      return ListView(children: list);
    }

    for (var account in accountList.accounts) {
      list.add(_tile(account, context));
    }

    return ListView(children: list);
  }

  ListTile _tile(BankAccountModel account, BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => transactionListView,
        ),
      ),
      title: Table(children: [
        TableRow(children: [
          Text(account.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ))
        ]),
        TableRow(children: [_transactionsSum(account.name)])
      ]),
      leading: Icon(
        Icons.account_balance_wallet,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _transactionsSum(String account) {
    return Table(children: [
      TableRow(children: [
        const Text("Total:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        TransactionSumContainer(bankAccount: account),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: vm.observe(),
      builder: (context, value, child) {
        return buildList(value.success, context);
      },
    );
  }
}
