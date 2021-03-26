import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/Bottom_sheet.dart';
import 'package:flutter_complete_guide/widgets/Chart.dart';
import 'package:flutter_complete_guide/widgets/List_transactions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isNum(txt) {
    if (double.tryParse(txt) == null) return false;
    return true;
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (ctx1) {
        return WidgetsBottomSheet(
          addTransaction: addTransaction,
        );
      },
    );
  }

  void addTransaction(String title, amount, date) {
    if (title == "" ||
        !isNum(amount) ||
        double.parse(amount) < 0 ||
        date == null) {
      return;
    }
    setState(
      () {
        _userTransactions.add(
          Transaction(
              id: "${_userTransactions.length + 1}",
              title:
                  "${title.substring(0, 1).toUpperCase()}${title.substring(1).toLowerCase()}",
              amount: double.parse(amount),
              date: date),
        );
        Navigator.of(context).pop();
      },
    );
  }

  void deleteTransiction(String id) {
    setState(
      () {
        _userTransactions.removeWhere((element) => element.id == id);
      },
    );
  }

  List<Transaction> _userTransactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _userTransactions.isEmpty
              ? [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            'No Expenses.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Container(
                            padding: EdgeInsets.only(top: 30),
                            height: 250,
                            child: Image(
                              image: AssetImage('assets/images/waiting.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [
                  Chart(
                    recentTransactions: _recentTransactions,
                  ),
                  ListTransactions(_userTransactions, deleteTransiction),
                ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
