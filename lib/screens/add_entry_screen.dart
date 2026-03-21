import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/storage_service.dart';

class AddEntryScreen extends StatefulWidget {
  final VoidCallback onSave;

  const AddEntryScreen({super.key, required this.onSave});

  @override
  State<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final amountCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  bool isIncome = true;

  void save() async {
    double amt = double.parse(amountCtrl.text);
    if (!isIncome) amt = -amt;

    var tx = TransactionModel(
      date: DateTime.now().toString(),
      amount: amt,
      note: noteCtrl.text,
    );

    var list = await StorageService.load();
    list.add(tx);
    await StorageService.save(list);

    widget.onSave();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Switch(
                value: isIncome,
                onChanged: (v) => setState(() => isIncome = v)),
            TextField(controller: amountCtrl, keyboardType: TextInputType.number),
            TextField(controller: noteCtrl),
            ElevatedButton(onPressed: save, child: const Text("Save"))
          ],
        ),
      ),
    );
  }
}
