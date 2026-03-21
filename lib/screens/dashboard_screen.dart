import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';
import 'add_entry_screen.dart';
import '../widgets/chart_widget.dart';
import '../utils/insights.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<TransactionModel> txs = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    txs = await StorageService.load();
    setState(() {});
  }

  double get income =>
      txs.where((t) => t.amount > 0).fold(0, (a, b) => a + b.amount);

  double get expense =>
      txs.where((t) => t.amount < 0).fold(0, (a, b) => a + b.amount.abs());

  @override
  Widget build(BuildContext context) {
    double balance = income - expense;

    return Scaffold(
      appBar: AppBar(title: const Text("💎 Fintech Dashboard")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddEntryScreen(onSave: loadData)));
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("💰 Balance",
                    style: TextStyle(fontSize: 18, color: Colors.grey)),

                Text("₹${balance.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Income: ₹$income"),
                    Text("Expense: ₹$expense"),
                  ],
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 200,
                  child: ChartWidget(txs: txs),
                ),

                const SizedBox(height: 20),

                Text(
                  generateInsights(income, expense),
                  style: TextStyle(color: Colors.orange),
                ),

                const SizedBox(height: 20),

                if (txs.isEmpty)
                  Center(
                    child: Text(
                      "No transactions yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
