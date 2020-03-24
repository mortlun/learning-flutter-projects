import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_app/counter.dart';

void main() {
  group("Counter", () {
    test('Value should start at 0', () {
      expect(Counter().value, 0);
    });

    test('Value should be decremented', () {
      final counter = Counter();
      counter.decrement();

      expect(counter.value, -1);
    });

    test("Counter value should be incremented", () {
      final counter = Counter();

      counter.increment();

      expect(counter.value, 1);
    });
  });
}
