// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:video_poker/card.dart';

import 'package:video_poker/main.dart';

void main() {
  test('Generate asset file name for cards', () {
    expect(PlayCard(1, 1).src, "assets/cards/card1a.png");
    expect(PlayCard(2, 2).src, "assets/cards/card22.png");
    expect(PlayCard(5, 3).src, "assets/cards/card35.png");
    expect(PlayCard(7, 4).src, "assets/cards/card47.png");
    expect(PlayCard(9, 1).src, "assets/cards/card19.png");
    expect(PlayCard(10, 2).src, "assets/cards/card2t.png");
    expect(PlayCard(11, 3).src, "assets/cards/card3j.png");
    expect(PlayCard(12, 4).src, "assets/cards/card4q.png");
    expect(PlayCard(13, 1).src, "assets/cards/card1k.png");
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

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
}
