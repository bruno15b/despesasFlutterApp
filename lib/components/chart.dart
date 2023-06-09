import 'package:despesas_flutter_app/components/chart_bar.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import "package:intl/intl.dart";

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < this.recentTransaction.length; i++) {
        bool sameDay = this.recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = this.recentTransaction[i].date.month == weekDay.month;
        bool sameYear = this.recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += this.recentTransaction[i].value;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay)[0],
        "value": totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this.groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"],
                value: tr["value"],
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr["value"] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
