import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_vm.dart';

class TransactionListView extends StatelessWidget {
  final TransactionVM vm = TransactionVM();

  TransactionListView({super.key});

  ListView buildList(List<TransactionModel> transactions) {
    List<ListTile> list = [];

    for (var transaction in transactions) {
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
