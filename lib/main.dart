// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import './widgets/chart.dart';

import './widgets/transactions_list.dart';

import './widgets/new_transaction.dart';

import 'package:flutter/material.dart';

import 'models/transactions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.amber),
        // errorColor: Colors.purple,
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 12.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Food',
      amount: 12.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Movies',
      amount: 10.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Whyyy',
      amount: 19.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Heeere',
      amount: 15.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Theen',
      amount: 48.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'Noow',
      amount: 31.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime time) {
    final txNew = Transaction(
      id: 't${_userTransactions.length + 1}',
      title: txTitle,
      amount: txAmount,
      date: time,
    );
    setState(() {
      _userTransactions.add(txNew);
    });
  }

  // String titleInput = "";
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: ((_) {
        return GestureDetector(
          onTap: (() {}),
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      }),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
