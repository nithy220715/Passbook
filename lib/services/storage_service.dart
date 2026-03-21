
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class StorageService {
  static const key = "txs";

  static Future<List<TransactionModel>> load() async {
    final p = await SharedPreferences.getInstance();
    final data = p.getString(key);
    if (data == null) return [];
    return (jsonDecode(data) as List).map((e)=>TransactionModel(
      date: e['date'], amount: e['amount'], note: e['note']
    )).toList();
  }

  static Future<void> save(List<TransactionModel> txs) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(key, jsonEncode(txs.map((e)=>{'date':e.date,'amount':e.amount,'note':e.note}).toList()));
  }
}
