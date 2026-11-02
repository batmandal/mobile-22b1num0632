// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:shoplite/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ShopLiteApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Decrement button decreases and never goes below 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ShopLiteApp());

    // Эхлээд 0 байна; – товч дарахад 0-ээс доош орохгүй.
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);

    // 2 удаа нэмээд 1 удаа хасахад 1 болно.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Max 10 shows error text and refresh resets to 0',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ShopLiteApp());

    for (var i = 0; i < 12; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
    }
    // 10-аас дээш гарахгүй, анхааруулга гарна.
    expect(find.text('10'), findsOneWidget);
    expect(find.text('Нэг удаад 10-аас олон бараа захиалах боломжгүй'),
        findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Нэг удаад 10-аас олон бараа захиалах боломжгүй'),
        findsNothing);
  });
}
