import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_finance_organizer/create_transaction_screen.dart';
import 'package:simple_finance_organizer/transaction_list_view.dart';
import 'package:simple_finance_organizer/transaction_vm.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Financeiro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TransactionVM? vm;
  var isFirebaseReady = false;

  HomePageState() {
    Future(() => _startFirebase());
  }

  void _startFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    vm = TransactionVM();

    setState(() {
      isFirebaseReady = true;
    });
  }

  Widget _createContent() {
    if (!isFirebaseReady) {
      return const Scaffold(
        body: Center(
          child: Text("Carregando..."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Controle Financeiro"),
      ),
      body: Center(child: TransactionListView(vm: vm!)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTransactionScreen(vm: vm!),
            ),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createContent();
  }

  @override
  void dispose() {
    if (vm != null) {
      vm!.dispose();
    }
    super.dispose();
  }
}
