import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class ChartWidget extends StatelessWidget {
  final List<TransactionModel> txs;

  const ChartWidget({super.key, required this.txs});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: txs.length.toDouble())
          ])
        ],
      ),
    );
  }
}
