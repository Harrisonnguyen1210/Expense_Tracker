import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraint) => Column(
              children: <Widget>[
                Text(
                  'No transaction yet',
                  style: Theme.of(context).textTheme.title,
                ),
                Divider(
                  height: 10,
                  color: Colors.white,
                ),
                Container(
                  height: constraint.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
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
                          child: Text(
                              '${transactions[index].amount.toStringAsFixed(2)}\$')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat('yyyy-MM-dd').format(transactions[index].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTransaction(index),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
