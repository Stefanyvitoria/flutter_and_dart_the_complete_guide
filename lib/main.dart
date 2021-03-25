import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/List_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expenses - App 04',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (ctx1) {
        return SingleChildScrollView(
          child: Container(
            height: 200,
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
            title: titleController.text,
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
    Transaction(
      id: '0',
      title: 'Shoes',
      amount: 89.90,
      date: DateTime.now(),
    ),
    Transaction(
      id: '1',
      title: 'Shirts',
      amount: 19.90,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal expenses - App 04"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                child: Text("CHARTS"),
                color: Colors.blue,
              ),
            ),
            ListTransactions(_userTransactions),
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
