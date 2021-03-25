import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/Chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, Object>> get transactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double sumDay = 0.0;

        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            sumDay += recentTransactions[i].amount;
          }
        }

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1).toUpperCase(),
          'amount': sumDay,
        };
      },
    ).reversed.toList();
  }

  double get totalamount {
    return transactionsValues.fold(
      0.0,
      (sum, element) {
        return sum + element['amount'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionsValues.map(
            (e) {
              return Flexible(
                child: ChartBar(
                  label: e['day'],
                  amount: e['amount'],
                  pctOfTotal: totalamount == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalamount,
                ),
                fit: FlexFit.tight,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
