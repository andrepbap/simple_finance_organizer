import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';

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
      list.add(_tile(transaction.description, transaction.value.toString(),
          transaction.date, Icons.money));
    }

    return ListView(children: list);
  }

  ListTile _tile(String title, String subtitle, Timestamp date, IconData icon) {
    return ListTile(
      title: Table(children: [
        TableRow(children: [
          Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ))
        ]),
        TableRow(children: [
          Text(date.toDate().toIso8601String(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ))
        ])
      ]),
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
