// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';

import './widgets/transactions_list.dart';

import './widgets/new_transaction.dart';

import 'models/transactions.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .titleLarge,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
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

  bool _showChart = false;

  // @override
  // void initState() {
  //   //create an observer for this class
  //   // WidgetsBinding.instance.addObserver(this);
  //   super.initState();
  // }

//To check if the state of an app changed
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state);
  // }

  // @override
  // dispose() {
  //   //To clear the observer created
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

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

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget transactionsContainer) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).colorScheme.secondary,
            value: _showChart,
            onChanged: (val) {
              setState(
                () {
                  _showChart = val;
                },
              );
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : transactionsContainer
    ];
  }

  List<Widget> _buildPotraitContent(MediaQueryData mediaQuery,
      PreferredSizeWidget appBar, Widget transactionsContainer) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.2,
        child: Chart(_recentTransactions),
      ),
      transactionsContainer
    ];
  }

  PreferredSizeWidget _buildAppBarContent() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: const Text(
              'Personal Expenses',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBarContent();

    final transactionsContainer = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: TransactionList(
        _userTransactions,
        _deleteTransaction,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                  mediaQuery, appBar, transactionsContainer),
            if (!isLandscape)
              ..._buildPotraitContent(
                  mediaQuery, appBar, transactionsContainer),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
