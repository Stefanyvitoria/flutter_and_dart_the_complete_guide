import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/Chart.dart';
import 'package:flutter_complete_guide/widgets/List_transactions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

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
        return SingleChildScrollView(
          child: Container(
            //height: 200,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title:'),
                ),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(labelText: 'Amount:'),
                  keyboardType: TextInputType.number,
                ),
                TextButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: Text("Add Transaction"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  bool isNum(txt) {
    if (double.tryParse(amountController.text) == null) return false;
    return true;
  }

  void addTransaction() {
    if (titleController.text == "" ||
        amountController.text == "" ||
        !isNum(amountController.text) ||
        double.parse(amountController.text) < 0) {
      return;
    }
    setState(
      () {
        _userTransactions.add(
          Transaction(
            id: "${_userTransactions.length + 1}",
            title:
                "${titleController.text.substring(0, 1).toUpperCase()}${titleController.text.substring(1).toLowerCase()}",
            amount: double.parse(amountController.text),
            date: DateTime.now(),
          ),
        );
        Navigator.of(context).pop();

        titleController.clear();
        amountController.clear();
      },
    );
  }

  List<Transaction> _userTransactions = [
    Transaction(id: "1", title: "Title", amount: 20, date: DateTime.now()),
    Transaction(id: "2", title: "Title", amount: 40, date: DateTime.now())
  ];

  void deleteTransiction(String id) {
    setState(
      () {
        _userTransactions.removeWhere((element) => element.id == id);
      },
    );
  }

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
