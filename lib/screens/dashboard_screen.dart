import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';
import 'settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  List<TransactionModel> txs = [];

  load() async {
    txs = await StorageService.load();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  double get income => txs.where((e)=>e.amount>0).fold(0,(a,b)=>a+b.amount);
  double get expense => txs.where((e)=>e.amount<0).fold(0,(a,b)=>a+b.amount.abs());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Passbook"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const SettingsScreen())).then((_)=>load()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Balance: ₹${income-expense}"),
            Text("Income: ₹$income"),
            Text("Expense: ₹$expense"),
            Expanded(
              child: ListView.builder(
                itemCount: txs.length,
                itemBuilder: (_,i){
                  var t=txs[i];
                  return ListTile(
                    title: Text(t.note),
                    subtitle: Text(t.date),
                    trailing: Text("₹${t.amount}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
