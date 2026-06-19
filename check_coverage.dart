import 'dart:io';

void main() {
  final lcovFile = File('coverage/lcov.info');
  if (!lcovFile.existsSync()) {
    print('No coverage/lcov.info found.');
    return;
  }

  final lines = lcovFile.readAsLinesSync();
  int totalLines = 0;
  int coveredLines = 0;

  String? currentFile;
  int fileTotal = 0;
  int fileCovered = 0;

  final Map<String, List<int>> uncoveredData = {};

  for (var line in lines) {
    if (line.startsWith('SF:')) {
      currentFile = line.substring(3);
      fileTotal = 0;
      fileCovered = 0;
      uncoveredData[currentFile] = [];
    } else if (line.startsWith('DA:')) {
      final parts = line.substring(3).split(',');
      final lineNum = int.parse(parts[0]);
      final hits = int.parse(parts[1]);
      
      fileTotal++;
      totalLines++;
      if (hits > 0) {
        fileCovered++;
        coveredLines++;
      } else {
        uncoveredData[currentFile]!.add(lineNum);
      }
    } else if (line == 'end_of_record') {
      if (currentFile != null) {
        if (currentFile.contains('create_booking_screen.dart')) {
          print('$currentFile: $fileCovered / $fileTotal = ${(fileCovered / fileTotal * 100).toStringAsFixed(2)}%');
          print('Uncovered lines: ${uncoveredData[currentFile]}');
        }
      }
    }
  }

  print('Overall coverage: $coveredLines / $totalLines = ${(coveredLines / totalLines * 100).toStringAsFixed(2)}%');
}
