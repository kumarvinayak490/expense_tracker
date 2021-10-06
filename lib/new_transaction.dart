import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  final Function updateHandler;

  NewTransaction(this.updateHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }
    widget.updateHandler(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              // onChanged: (value) {
              //   amountInput = value;
              // },
              controller: amountController,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'No Date Chosen'
                          : ' Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      'Choose a date',
                    ),
                    textColor: Theme.of(context).textTheme.button.color,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  submitData();
                },
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
