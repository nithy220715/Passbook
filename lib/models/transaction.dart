
class TransactionModel {
  String date;
  double amount;
  String note;

  TransactionModel({required this.date, required this.amount, required this.note});

  bool get isIncome => amount > 0;
}
