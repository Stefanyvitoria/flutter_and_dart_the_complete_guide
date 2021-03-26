import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class ListTransactions extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  ListTransactions(this.transactions, this.deleteTransaction);

  @override
  _ListTransactionsState createState() => _ListTransactionsState();
}

class _ListTransactionsState extends State<ListTransactions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 465,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: widget.transactions.length,
          itemBuilder: (ctx, index) {
            Transaction transaction = widget.transactions[index];
            return Card(
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "\$${transaction.amount.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context)
                              .appBarTheme
                              .titleTextStyle
                              .color,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "${transaction.title}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transaction.date),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                trailing: IconButton(
                  onPressed: () => widget.deleteTransaction(transaction.id),
                  color: Theme.of(context).errorColor,
                  icon: Icon(
                    Icons.delete,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
