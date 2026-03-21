import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/storage_service.dart';
import '../services/csv_service.dart';
import '../models/transaction.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  importData(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final content = String.fromCharCodes(result.files.first.bytes!);
      List<TransactionModel> newTxs = CsvService.import(content);

      if (newTxs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid CSV")),
        );
        return;
      }

      bool confirm = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Replace Data"),
          content: const Text("Clear old data and import new?"),
          actions: [
            TextButton(onPressed: ()=>Navigator.pop(context,false), child: const Text("Cancel")),
            ElevatedButton(onPressed: ()=>Navigator.pop(context,true), child: const Text("Confirm")),
          ],
        ),
      ) ?? false;

      if (!confirm) return;

      await StorageService.save(newTxs);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Imported ${newTxs.length} records")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>importData(context),
          child: const Text("Import CSV (Replace All)"),
        ),
      ),
    );
  }
}
