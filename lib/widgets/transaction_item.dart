import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required Function deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction transaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: FittedBox(
                child: Text('${transaction.amount.toStringAsFixed(2)}\$')),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(transaction.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: mediaQuery.size.width > 480
            ? FlatButton.icon(
                onPressed: _deleteTransaction,
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: _deleteTransaction,
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
