import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WidgetsBottomSheet extends StatefulWidget {
  final Function addTransaction;

  WidgetsBottomSheet({this.addTransaction});

  @override
  _WidgetsBottomSheetState createState() => _WidgetsBottomSheetState();
}

class _WidgetsBottomSheetState extends State<WidgetsBottomSheet> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _dateSelected;

  void salectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _dateSelected = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title:'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount:'),
              keyboardType: TextInputType.number,
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_dateSelected == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_dateSelected)}'),
                TextButton(
                  onPressed: salectDate,
                  child: Text('Choose Date'),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                widget.addTransaction(
                  _titleController.text,
                  _amountController.text,
                  _dateSelected,
                );
              },
              child: Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
