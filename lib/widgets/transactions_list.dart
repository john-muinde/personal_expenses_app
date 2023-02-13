// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import 'dart:math';

import '../models/transactions.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions, this.deleteTransactions);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  TextStyle get styles {
    return TextStyle(
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No Transactions Found',
                    style: styles,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: widget.transactions
                .map((tx) => TransactionItem(
                      // key: UniqueKey(),
                      key: ValueKey(tx.id),
                      transaction: tx,
                      styles: styles,
                      deleteTransaction: widget.deleteTransactions,
                    ))
                .toList(),
          );
  }
}
