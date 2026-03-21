
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/transaction.dart';

class CsvService {

  static Future<String> export(List<TransactionModel> txs) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/passbook.csv");

    String csv = "Date,Note,Type,Amount\n";
    for (var t in txs) {
      String type = t.amount > 0 ? "Income" : "Expense";
      csv += "${t.date},${t.note},${type},${t.amount.abs()}\n";
    }

    await file.writeAsString(csv);
    return file.path;
  }

  static List<TransactionModel> import(String content) {
    final lines = const LineSplitter().convert(content);
    if (lines.length < 2) return [];

    final headers = lines[0].toLowerCase().split(",");

    int d = headers.indexWhere((e)=>e.contains("date"));
    int a = headers.indexWhere((e)=>e.contains("amount"));
    int n = headers.indexWhere((e)=>e.contains("note"));
    int t = headers.indexWhere((e)=>e.contains("type"));

    List<TransactionModel> list = [];

    for(int i=1;i<lines.length;i++){
      final c = lines[i].split(",");
      try{
        double amt = double.parse(c[a]);
        if(t!=-1 && c[t].toLowerCase().contains("expense")){
          amt = -amt;
        }
        list.add(TransactionModel(
          date: c[d],
          amount: amt,
          note: n!=-1 ? c[n] : "Other"
        ));
      }catch(_){}
    }
    return list;
  }
}
