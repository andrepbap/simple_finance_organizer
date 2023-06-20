import 'package:flutter/material.dart';
import 'package:simple_finance_organizer/usecase/sum_transaction_usecase.dart';

class TransactionSumContainer extends StatefulWidget {
  final sumTransactionUsecase = SumTransactionUsecase();

  TransactionSumContainer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TransactionSumContainerState();
  }
}

class _TransactionSumContainerState extends State<TransactionSumContainer> {
  double sumState = 0.0;

  _TransactionSumContainerState() {
    Future(() => _sum());
  }

  void _sum() async {
    var sum = await widget.sumTransactionUsecase.sum();

    setState(() {
      sumState = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('R\$ ${sumState.toString()}',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ));
  }
}
