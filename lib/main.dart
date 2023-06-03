import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_finance_organizer/transaction_model.dart';
import 'package:simple_finance_organizer/transaction_vm.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void _startFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    Future(() => _startFirebase());

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var state = TransactionState([]);
  late TransactionVM vm;

  _MyHomePageState() {
    vm = TransactionVM();
    vm.state = state;
  }

  void _getTransactions() {
    vm.getTransactions(setState);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView(
        children: tiles,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTransactions,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
