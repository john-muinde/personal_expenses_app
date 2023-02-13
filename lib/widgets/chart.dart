import './chart_bar.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get getGroupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year &&
            recentTransactions[i].date.day == weekDay.day) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(totalSum);
      // print(DateFormat.E().format(weekDay));

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return getGroupedTransactions.fold(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    // print(getGroupedTransactions);
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactions
              .map(
                (recentTrans) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    recentTrans['day'] as String,
                    recentTrans['amount'] as double,
                    totalSpending == 0.0
                        ? 0.0
                        : (recentTrans['amount'] as double) / totalSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
