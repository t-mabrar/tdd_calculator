class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    List<String> delimiters = [",", "\n", ""];
    String numbersPart = numbers;

    // Custom delimiter check
    if (numbers.startsWith("//")) {
      final parts = numbers.split("\n");
      final delimiterLine = parts.first.substring(2); // after //
      delimiters = [delimiterLine];
      numbersPart = parts.sublist(1).join("\n");
    }

    // Split numbers by delimiters
    final tokens = numbersPart
        .split(RegExp(delimiters.map(RegExp.escape).join("|")))
        .where((t) => t.isNotEmpty)
        .toList();

    final parsedNumbers = <int>[];

    for (final token in tokens) {
      final value = int.tryParse(token);
      if (value == null) {
        throw FormatException("Invalid number: '$token'");
      }
      parsedNumbers.add(value);
    }

    // Explicit negative number check
    final negatives = parsedNumbers.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception("negative numbers not allowed: ${negatives.join(",")}");
    }

    return parsedNumbers.fold(0, (sum, n) => sum + n);
  }
}
