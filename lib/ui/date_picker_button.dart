import 'package:flutter/material.dart';

class DatePickerButton extends StatefulWidget {
  final Function onSelectDate;

  const DatePickerButton({super.key, required this.onSelectDate});

  @override
  State<StatefulWidget> createState() {
    return _DatePickerButtonState();
  }
}

class _DatePickerButtonState extends State<DatePickerButton> {
  var dateState = DateTime.now();

  void getFromDatePicker(BuildContext context) async {
    var selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2099));

    if (selectedDate == null) {
      return;
    }

    widget.onSelectDate(selectedDate);

    setState(() {
      dateState = selectedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => getFromDatePicker(context),
        child: Text(dateState.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20)));
  }
}
