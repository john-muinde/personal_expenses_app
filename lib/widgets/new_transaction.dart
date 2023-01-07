// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function transactionsHandler;

  NewTransaction(this.transactionsHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var datePickerController;

  // const NewTransaction({super.key});
  void submitData() {
    final enteredTitle = titleController.text;
    double enteredAmount;
    try {
      enteredAmount = double.parse(amountController.text);
    } catch (e) {
      enteredAmount = 0;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.transactionsHandler(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (_) => submitData(),
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // TextField(
                  //   // controller: datePickerController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Date',
                  //   ),
                  // ),
                  Text('Not selected'),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.primary,
                ),

              ),
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
