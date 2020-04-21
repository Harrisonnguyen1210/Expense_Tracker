import 'package:flutter/material.dart';
import 'transaction_item.dart';
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
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: () => _deleteTransaction(index));
            },
            itemCount: transactions.length,
          );
  }
}
