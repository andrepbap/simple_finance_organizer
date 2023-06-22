import 'package:flutter/material.dart';

class DatePickerButton extends StatefulWidget {
  final Function onSelectDate;
  final DateTime? initialValue;

  const DatePickerButton(
      {super.key, required this.onSelectDate, this.initialValue});

  @override
  State<StatefulWidget> createState() {
    return _DatePickerButtonState();
  }
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime? _dateState;

  void _getFromDatePicker(BuildContext context) async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: _dateState!,
        firstDate: DateTime(2020),
        lastDate: DateTime(2099));

    if (selectedDate == null) {
      return;
    }

    widget.onSelectDate(selectedDate);

    setState(() {
      _dateState = selectedDate;
    });
  }

  DateTime _dateValue() {
    _dateState ??= widget.initialValue;

    return _dateState!;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => _getFromDatePicker(context),
        child: Text(_dateValue().toString(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)));
  }
}
