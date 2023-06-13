import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';

class CreateTransactionScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TransactionVM vm;

  CreateTransactionScreen({super.key, required this.vm});

  void getFromDatePicker(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2099));
  }

  @override
  Widget build(BuildContext context) {
    String description = "";
    double value = 0;
    late DateTime date;

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
                  TextFormField(
                    onTap: () => getFromDatePicker(context),
                    onSaved: (newValue) => date = DateTime.parse(newValue!),
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(hintText: "Data"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entre com um valor';
                      }
                      return null;
                    },
                  ),
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
