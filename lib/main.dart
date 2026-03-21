
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintech App',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double balance = 0;

  void addIncome() {
    setState(() => balance += 100);
  }

  void addExpense() {
    setState(() => balance -= 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("💎 Fintech App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Balance", style: TextStyle(color: Colors.grey)),
            Text("₹${balance.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: addIncome, child: Text("Add Income")),
            ElevatedButton(onPressed: addExpense, child: Text("Add Expense")),
          ],
        ),
      ),
    );
  }
}
