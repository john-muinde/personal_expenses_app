// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors
import '../models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class TransactionList extends StatelessWidget {
  TextStyle get styles {
    return TextStyle(
      fontFamily: 'Quicksand',
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  final List<Transaction> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions, this.deleteTransactions);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                'No Transactions Found',
                style: styles,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/image/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return InkWell(
                onTap: () {
                  SnackBar(
                    content: Text("Long pressed"),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: styles,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMEEEEd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () =>
                          deleteTransactions(transactions[index].id),
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}





//  child: Card(
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 15),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: Theme.of(context).colorScheme.primary,
//                               width: 2,
//                             ),
//                           ),
//                           padding: EdgeInsets.all(10),
//                           child: Text(
//                             '\$${transactions[index].amount.toStringAsFixed(2)}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Theme.of(context).colorScheme.primary,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               transactions[index].title,
//                               style: styles,
//                             ),
//                             Text(
//                               DateFormat.yMMMMEEEEd()
//                                   .format(transactions[index].date),
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
