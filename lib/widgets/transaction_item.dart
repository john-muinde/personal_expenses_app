import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.styles,
    required this.deleteTransaction,
  });

  final Transaction transaction;
  final TextStyle styles;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const _colors = [Colors.red, Colors.purple, Colors.pink, Colors.orange];
    _bgColor = _colors[Random().nextInt(_colors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        const SnackBar(
          content: Text("Long pressed"),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            // leading: Container(
            //   decoration: BoxDecoration(
            //       color: Theme.of(context).colorScheme.primary,
            //       shape: BoxShape.circle),
            //   height: 60,
            //   width: 60,
            // backgroundColor: Color(
            //         (math.Random().nextDouble() * 0xFFFFFF).toInt())
            //     .withOpacity(0.5),
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: widget.styles,
          ),
          subtitle: Text(
            DateFormat.yMMMMEEEEd().format(widget.transaction.date),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.error),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () =>
                      widget.deleteTransaction(widget.transaction.id),
                ),
        ),
      ),
    );
  }
}
