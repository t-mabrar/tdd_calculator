import 'package:tdd_calculator/tdd_calculator.dart';
import 'package:test/test.dart';

void main() {
  final calculator = StringCalculator();
  group("Valid inputs", () {
    test('Empty string returns 0', () {
      expect(calculator.add(""), equals(0));
    });

    test('Single number returns itself', () {
      expect(calculator.add("1"), equals(1));
    });

    test('Two numbers comma separated', () {
      expect(calculator.add("1,5"), equals(6));
    });

    test('Multiple numbers comma separated', () {
      expect(calculator.add("1,2,3,4"), equals(10));
    });

    test('Numbers with new lines', () {
      expect(calculator.add("1\n2,3"), equals(6));
    });

    test('Custom delimiter ;', () {
      expect(calculator.add("//;\n1;2"), equals(3));
    });

    test('Custom delimiter |', () {
      expect(calculator.add("//|\n2|3|4"), equals(9));
    });
  });

  group("Negative numbers", () {
    test('Single negative number throws', () {
      expect(
        () => calculator.add("-1"),
        throwsA(
          predicate(
            (e) => e.toString().contains("negative numbers not allowed: -1"),
          ),
        ),
      );
    });

    test('Multiple negative numbers throw with all listed', () {
      expect(
        () => calculator.add("1,-2,3,-4"),
        throwsA(
          predicate(
            (e) => e.toString().contains("negative numbers not allowed: -2,-4"),
          ),
        ),
      );
    });
  });
}
