class TransactionModel {
  String date;
  double amount;
  String note;

  TransactionModel({
    required this.date,
    required this.amount,
    required this.note,
  });

  bool get isIncome => amount > 0;

  Map<String, dynamic> toJson() => {
        'date': date,
        'amount': amount,
        'note': note,
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      date: json['date'],
      amount: json['amount'],
      note: json['note'],
    );
  }
}
