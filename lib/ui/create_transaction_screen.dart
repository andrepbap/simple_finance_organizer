import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';

class CreateTransactionScreen extends StatefulWidget {
  final TransactionVM vm;

  const CreateTransactionScreen({super.key, required this.vm});

  @override
  State<StatefulWidget> createState() {
    return CreateTransactionScreenState(vm);
  }

}

class CreateTransactionScreenState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TransactionVM vm;

  String description = "";
  double value = 0;
  DateTime date = DateTime.now();

  CreateTransactionScreenState(this.vm);

  void getFromDatePicker(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2099)).then((value) => {
          setState(() {
            if (value != null) {
              date = value;
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Nova Transação"),
      ),
      body: Container(
          margin: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onSaved: (newValue) => description = newValue!,
                    decoration: const InputDecoration(hintText: "Descrição"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entre com um nome';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                  TextFormField(
                    onSaved: (newValue) => value = double.parse(newValue!),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Valor"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entre com um valor';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                  TextButton(
                      onPressed: () => getFromDatePicker(context),
                      child: Text(date.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            vm.createTransaction(description, value, date);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Salvar")),
                  )
                ],
              ))),
    );
  }
}
