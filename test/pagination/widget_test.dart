import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter2_practice/src/pagination/pagination_widget.dart';

void main() {
  group('MyWidget', () {
    testWidgets('should not see the left double arrow',
        (WidgetTester tester) async {
      int pageTest = 0;

      // Define a Widget
      final myWidget = PaginationWidget(
        nowPage: 1,
        lastPage: 1,
        gotoPage: (int page) {
          pageTest = page;
        },
      );

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: myWidget)));

      // Verify myWidget shows some text
      expect(find.byType(GoToFirstButton), findsNothing);

      final button1Finder = find.byType(TextButton);
      await tester.tap(button1Finder);
      // 選択中のページボタンは押しても何も起こらないはず
      expect(pageTest, 0);
    });

    testWidgets('should see the left double arrow',
        (WidgetTester tester) async {
      int pageTest = 0;
      // Define a Widget
      final myWidget = PaginationWidget(
        nowPage: 2,
        lastPage: 2,
        gotoPage: (int page) {
          pageTest = page;
        },
      );

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: myWidget)));

      // Verify myWidget shows some text
      expect(find.byType(GoToFirstButton), findsOneWidget);

      await tester.tap(find.byKey(ValueKey(1)));
      expect(pageTest, 1);

      await tester.tap(find.byKey(ValueKey(2)));
      expect(pageTest, 1);
    });

    testWidgets('should see the left and right double arrow',
        (WidgetTester tester) async {
      int pageTest = 0;
      // Define a Widget
      final myWidget = PaginationWidget(
        nowPage: 2,
        lastPage: 3,
        gotoPage: (int page) {
          pageTest = page;
        },
      );

      // Build myWidget and trigger a frame.
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: myWidget)));

      expect(find.byType(GoToFirstButton), findsOneWidget);
      expect(find.byType(DoubleArrowTextButton), findsNWidgets(2));

      await tester.tap(find.byKey(ValueKey(1)));
      expect(pageTest, 1);

      await tester.tap(find.byKey(ValueKey(2)));
      expect(pageTest, 1);

      await tester.tap(find.byKey(ValueKey(3)));
      expect(pageTest, 3);

      expect(find.byKey(ValueKey(4)), findsNothing);
    });
  });
}
