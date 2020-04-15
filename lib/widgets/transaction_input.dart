import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInput extends StatefulWidget {
  final Function _addNewTransaction;

  TransactionInput(this._addNewTransaction);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime _selectedDate;

  void _addTransaction() {
    final title = _titleEditingController.text;
    final amount = double.tryParse(_amountEditingController.text);
    if (title.isNotEmpty &&
        amount != null &&
        amount >= 0 &&
        _selectedDate != null) {
      widget._addNewTransaction(title, amount, _selectedDate);
    }
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            lastDate: DateTime(2025),
            initialDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
                controller: _titleEditingController,
                decoration: InputDecoration(labelText: 'Title')),
            TextField(
              controller: _amountEditingController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _addTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen'
                          : DateFormat.yMd().format(_selectedDate),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () => _presentDatePicker(context),
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _addTransaction,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
