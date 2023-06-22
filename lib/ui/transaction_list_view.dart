import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/transaction_list_model.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';
import 'package:simple_finance_organizer/ui/create_transaction_screen.dart';
import 'package:simple_finance_organizer/ui/transaction_sum_container.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';

class TransactionListView extends StatelessWidget {
  final TransactionVM vm;

  TransactionListView({super.key, required this.vm}) {
    vm.getTransactions();
  }

  ListView buildList(
      TransactionListModel? transactionList, BuildContext context) {
    List<Widget> list = [];

    if (transactionList == null) {
      return ListView(children: list);
    }

    for (var transaction in transactionList.transactions) {
      list.add(_tile(transaction, context));
    }

    list.add(_transactionsSum());

    return ListView(children: list);
  }

  ListTile _tile(TransactionModel transaction, BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              CreateTransactionScreen(vm: vm, editingTransaction: transaction),
        ),
      ),
      title: Table(children: [
        TableRow(children: [
          Text(transaction.description,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ))
        ]),
        TableRow(children: [
          Text(transaction.date.toDate().toIso8601String(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ))
        ])
      ]),
      subtitle: Text(transaction.value.toString()),
      leading: Icon(
        Icons.money,
        color: Colors.blue[500],
      ),
    );
  }

  Widget _transactionsSum() {
    return Table(children: [
      TableRow(children: [
        const Text("Total:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        TransactionSumContainer(),
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
