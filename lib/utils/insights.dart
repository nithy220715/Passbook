String generateInsights(double income, double expense) {
  if (expense > income * 0.7) {
    return "⚠️ High spending detected";
  }
  return "✅ Good savings";
}
