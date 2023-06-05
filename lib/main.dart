import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_finance_organizer/transaction_list_view.dart';
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

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Center(child: TransactionListView()),
      floatingActionButton: FloatingActionButton(
        onPressed: TransactionVM.instance?.getTransactions,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
