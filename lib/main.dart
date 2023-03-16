import 'dart:math';
import 'package:despesas_flutter_app/components/chart.dart';
import 'package:despesas_flutter_app/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        fontFamily: "Roboto",
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [
    Transaction(
      id: "t1",
      title: "PS5",
      value: 4900,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: "t2",
      title: "Monitor",
      value: 1299.5,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
        id: "t3",
        title: "Mouse",
        value: 49.99,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
      id: "t4",
      title: "Ipad",
      value: 4900,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "t5",
      title: "Bike",
      value: 1600,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
        id: "t6",
        title: "Mercado",
        value: 601.87,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
      id: "t7",
      title: "PS2",
      value: 1500,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaciton(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(this._addTransaciton);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesas Pessoais"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(this._recentTransactions),
            TransactionList(this._transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
