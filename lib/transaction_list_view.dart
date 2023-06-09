import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/transaction_vm.dart';

class TransactionListView extends StatelessWidget {
  final TransactionVM vm;

  TransactionListView({super.key, required this.vm}) {
    vm.getTransactions();
  }

  ListView buildList(TransactionListModel? transactionList) {
    List<ListTile> list = [];

    if (transactionList == null) {
      return ListView(children: list);
    }

    for (var transaction in transactionList.transactions) {
      list.add(_tile(
          transaction.description, transaction.value.toString(), Icons.money));
    }

    return ListView(children: list);
  }

  ListTile _tile(String title, String subtitle, IconData icon) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.blue[500],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: vm.observe(),
      builder: (context, value, child) {
        return buildList(value.success);
      },
    );
  }
}
