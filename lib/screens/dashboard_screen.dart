
import 'package:flutter/material.dart';
import '../widgets/summary_card.dart';
import '../widgets/chart_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Premium Fintech")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Filters
            DropdownButton<String>(
              value: selectedFilter,
              items: ["All","Income","Expense"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => selectedFilter = v!),
            ),

            const SizedBox(height: 16),

            // Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(child: SummaryCard(title: "Income", value: "₹5000")),
                SizedBox(width: 10),
                Expanded(child: SummaryCard(title: "Expense", value: "₹3000")),
              ],
            ),

            const SizedBox(height: 20),

            // Chart
            SizedBox(height: 200, child: ChartWidget()),

            const SizedBox(height: 20),

            // Monthly table placeholder
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text("Jan"), trailing: Text("₹2000")),
                  ListTile(title: Text("Feb"), trailing: Text("₹3000")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
