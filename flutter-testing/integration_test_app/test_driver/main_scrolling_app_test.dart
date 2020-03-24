import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Scrollable app', () {
    FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });

    test('verfies the list contains a specific item', () async {
      final listFinder = find.byValueKey('long_list');
      final itemFinder = find.byValueKey('item_50_text');

      final timeline = await driver.traceAction(() async {
        await driver.scrollUntilVisible(listFinder, itemFinder, dyScroll: -300);
      });

      expect(await driver.getText(itemFinder), 'Item 50');

      final summary = TimelineSummary.summarize(timeline);

      summary.writeSummaryToFile('scrolling_summary',
          pretty: true, destinationDirectory: './logs');

      summary.writeTimelineToFile('scrolling_timeline',
          pretty: true, destinationDirectory: './logs');
    });
  });
}
