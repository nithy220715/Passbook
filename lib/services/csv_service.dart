import 'dart:convert';
import 'dart:io';

class CsvService {
  // Static method to import CSV data
  static List<List<String>> importCsv(String filePath) {
    final file = File(filePath);
    final rows = <List<String>>[];
    Stream<String> lines = file.openRead() 
        .transform(utf8.decoder) // Decode bytes to UTF-8.
        .transform(LineSplitter()); // Convert stream to individual lines.

    lines.forEach((String line) {
      rows.add(line.split(',')); // Split each line into a list of values.
    });
    return rows;
  }

  // Static method to export data as CSV
  static void exportCsv(List<List<String>> data, String filePath) {
    final file = File(filePath);
    final sink = file.openWrite();
    for (var row in data) {
      sink.write(row.join(',') + '\n'); // Join each row's values with commas and add a newline.
    }
    sink.close(); // Close the file sink to finalize writing.
  }
}