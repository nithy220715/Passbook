import 'dart:convert';
import '../models/transaction.dart';

class CsvService {

  static List<TransactionModel> import(String content) {
    final lines = const LineSplitter().convert(content);
    if (lines.isEmpty) return [];

    final headers = lines[0].toLowerCase().split(",");

    int dateIndex = headers.indexWhere((h) => h.contains("date"));
    int amountIndex = headers.indexWhere((h) => h.contains("amount"));
    int noteIndex = headers.indexWhere((h) => h.contains("note"));
    int typeIndex = headers.indexWhere((h) => h.contains("type"));

    List<TransactionModel> txs = [];

    for (int i = 1; i < lines.length; i++) {
      final cols = lines[i].split(",");
      if (cols.length < 2) continue;

      try {
        String date = cols[dateIndex];
        double amount = double.parse(cols[amountIndex]);
        String note = noteIndex != -1 ? cols[noteIndex] : "Other";

        if (typeIndex != -1) {
          String type = cols[typeIndex].toLowerCase();
          if (type.contains("expense")) amount = -amount;
        }

        txs.add(TransactionModel(
          date: date,
          amount: amount,
          note: note,
        ));
      } catch (_) {}
    }

    return txs;
  }
}
