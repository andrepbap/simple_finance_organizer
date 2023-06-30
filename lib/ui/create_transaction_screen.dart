import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/model/transaction_model.dart';
import 'package:simple_finance_organizer/ui/date_picker_button.dart';
import 'package:simple_finance_organizer/ui/view_model/transaction_vm.dart';

class CreateTransactionScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TransactionVM vm;
  final TransactionModel? editingTransaction;

  CreateTransactionScreen(
      {super.key, required this.vm, this.editingTransaction});

  @override
  Widget build(BuildContext context) {
    String description = "";
    double value = 0;
    DateTime date = DateTime.now();
    String bankAccount = "";

    if (editingTransaction != null) {
      description = editingTransaction!.description;
      value = editingTransaction!.value;
      date = editingTransaction!.date.toDate();
      bankAccount = editingTransaction!.bankAccountName;
    }

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
                    initialValue: description,
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
                    initialValue: value.toString(),
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
                    initialValue: bankAccount,
                    onSaved: (newValue) => bankAccount = newValue!,
                    decoration: const InputDecoration(hintText: "Conta"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Conta em que a transação pertence';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                  DatePickerButton(
                      initialValue: date,
                      onSelectDate: (selectedDate) => date = selectedDate),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (editingTransaction != null) {
                              vm.updateTransaction(editingTransaction!.id!,
                                  description, value, date, bankAccount);
                            } else {
                              vm.createTransaction(
                                  description, value, date, bankAccount);
                            }
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
