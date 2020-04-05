import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Row(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2)),
                  child: Text(
                    '${transactions[index].amount.toStringAsFixed(2)}\$',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                )
              ]),
            );
          },
          itemCount: transactions.length,
        ));
  }
}
