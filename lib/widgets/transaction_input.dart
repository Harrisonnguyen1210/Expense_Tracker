import 'package:flutter/material.dart';

class TransactionInput extends StatefulWidget {
  final Function _addNewTransaction;

  TransactionInput(this._addNewTransaction);

  @override
  _TransactionInputState createState() => _TransactionInputState();
}

class _TransactionInputState extends State<TransactionInput> {
  final titleEditingController = TextEditingController();

  final amountEditingController = TextEditingController();

  void _addTransaction() {
    final title = titleEditingController.text;
    final amount = double.tryParse(amountEditingController.text);
    if (title.isNotEmpty && amount != null && amount >= 0) {
      widget._addNewTransaction(title, amount);
    }
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
                controller: titleEditingController,
                decoration: InputDecoration(labelText: 'Title')),
            TextField(
              controller: amountEditingController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _addTransaction(),
            ),
            FlatButton(
              onPressed: _addTransaction,
              textColor: Colors.purple,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
