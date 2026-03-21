import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class StorageService {
  static const key = "transactions";

  static Future<List<TransactionModel>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data == null) return [];
    List list = jsonDecode(data);
    return list.map((e) => TransactionModel.fromJson(e)).toList();
  }

  static Future<void> save(List<TransactionModel> txs) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = jsonEncode(txs.map((e) => e.toJson()).toList());
    await prefs.setString(key, jsonStr);
  }
}
