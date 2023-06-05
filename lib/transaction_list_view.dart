import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/screen_state.dart';
import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_vm.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key});

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  var state = ScreenState<TransactionModel>([]);
  late TransactionVM vm;

  _TransactionListViewState() {
    vm = TransactionVM.createWith(state, setState);
  }

  List<ListTile> buildList() {
    List<ListTile> list = [];

    for (var transaction in state.success) {
      list.add(_tile(
          transaction.description, transaction.value.toString(), Icons.money));
    }

    return list;
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
    var tiles = buildList();

    return ListView(
      children: tiles,
    );
  }
}
