
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/storage_service.dart';
import '../services/csv_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  importData(BuildContext context) async {
    var result = await FilePicker.platform.pickFiles();
    if(result==null) return;

    final content = String.fromCharCodes(result.files.first.bytes!);
    final data = CsvService.import(content);

    if(data.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid CSV"))
      );
      return;
    }

    await StorageService.save(data);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Imported ${data.length} rows"))
    );
  }

  exportData(BuildContext context) async {
    var txs = await StorageService.load();
    var path = await CsvService.export(txs);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Saved: "+path))
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children:[
            ElevatedButton(
              onPressed: ()=>importData(context),
              child: const Text("Import CSV")
            ),
            ElevatedButton(
              onPressed: ()=>exportData(context),
              child: const Text("Export CSV")
            ),
          ]
        ),
      ),
    );
  }
}
