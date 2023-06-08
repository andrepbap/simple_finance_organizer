import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/screen_state.dart';
import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_repository.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({super.key});

  @override
  State<TransactionListView> createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView>
    with WidgetsBindingObserver {
  var screenState = ScreenState<List<TransactionModel>>();
  late TransactionRepository repository;

  _TransactionListViewState() {
    repository = TransactionRepository();
  }

  List<ListTile> buildList() {
    List<ListTile> list = [];

    if (screenState.success == null) return list;

    for (var transaction in screenState.success!) {
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        repository.get().then((value) => {
              setState(() {
                screenState.success = value;
              })
            });
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
}
