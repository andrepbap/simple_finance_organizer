import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simple_finance_organizer/ui/bank_account_list_view.dart';
import 'package:simple_finance_organizer/ui/create_transaction_screen.dart';
import 'package:simple_finance_organizer/ui/transaction_list_view.dart';
import 'package:simple_finance_organizer/ui/view_model/bank_account_vm.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';
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
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  var isFirebaseReady = false;

  int _selectedIndex = 0;
  TransactionVM? transactionVM;
  BankAccountVM? bankAccountVM;
  late TransactionListView transactionListView;
  late BankAccountListView bankAccountListView;

  HomePageState() {
    Future(() => _startFirebase());
  }

  void _startFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    transactionVM = TransactionVM();
    transactionListView = TransactionListView(vm: transactionVM!);

    bankAccountVM = BankAccountVM();
    bankAccountListView = BankAccountListView(
        vm: bankAccountVM!, transactionListView: transactionListView);

    setState(() {
      isFirebaseReady = true;
    });
  }

  List<Widget> _getWidgetOptions() {
    return <Widget>[
      transactionListView,
      bankAccountListView,
      const Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // TODO tentar de outra forma
      bankAccountVM!.getBankAccounts();
    });
  }

  Widget _getScreenToNavigate() {
    switch (_selectedIndex) {
      case 0:
        return CreateTransactionScreen(vm: transactionVM!);
      case 1:
        return CreateTransactionScreen(vm: transactionVM!);
      default:
        return CreateTransactionScreen(vm: transactionVM!);
    }
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
        title: const Text("Todas as Transações"),
      ),
      body: _getWidgetOptions().elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => _getScreenToNavigate(),
            ),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Transações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Contas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _createContent();
  }

  @override
  void dispose() {
    if (transactionVM != null) {
      transactionVM!.dispose();
    }
    super.dispose();
  }
}
