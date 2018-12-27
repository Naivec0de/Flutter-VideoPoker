// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:video_poker/card.dart';
import 'package:video_poker/global.dart';

void main() {
  test('Generate asset file name for cards', () {
    expect(PlayCard.back().src, "assets/back.png");
    expect(PlayCard(1, suit: 1).src, "assets/cards/card1a.png");
    expect(PlayCard(2, suit: 2).src, "assets/cards/card22.png");
    expect(PlayCard(5, suit: 3).src, "assets/cards/card35.png");
    expect(PlayCard(7, suit: 4).src, "assets/cards/card47.png");
    expect(PlayCard(9, suit: 1).src, "assets/cards/card19.png");
    expect(PlayCard(10, suit: 2).src, "assets/cards/card2t.png");
    expect(PlayCard(11, suit: 3).src, "assets/cards/card3j.png");
    expect(PlayCard(12, suit: 4).src, "assets/cards/card4q.png");
    expect(PlayCard(13, suit: 1).src, "assets/cards/card1k.png");
  });

  test('Test generating sorted string from hand', () {
    expect(
        getSortedString([
          PlayCard(1, suit: 4),
          PlayCard(1, suit: 3),
          PlayCard(9, suit: 2),
          PlayCard(1, suit: 1),
          PlayCard(1, suit: 4),
        ]),
        '9aaaa');

    expect(
        getSortedString([
          PlayCard(7, suit: 4),
          PlayCard(10, suit: 2),
          PlayCard(2, suit: 3),
          PlayCard(11, suit: 1),
          PlayCard(12, suit: 4),
        ]),
        '27jqt');

    expect(
        getSortedString([
          PlayCard(13, suit: 1),
          PlayCard(10, suit: 3),
          PlayCard(13, suit: 2),
          PlayCard(2, suit: 4),
          PlayCard(13, suit: 4),
        ]),
        '2kkkt');

    expect(
        getSortedString([
          PlayCard(9, suit: 4),
          PlayCard(5, suit: 3),
          PlayCard(10, suit: 2),
          PlayCard(5, suit: 1),
          PlayCard(9, suit: 4),
        ]),
        '5599t');

    expect(
        getSortedString([
          PlayCard(11, suit: 4),
          PlayCard(12, suit: 3),
          PlayCard(10, suit: 2),
          PlayCard(1, suit: 1),
          PlayCard(13, suit: 4),
        ]),
        'ajkqt');
  });

  PlayCard createCard(rank) => PlayCard(rank);

  test('Test: four of a kind', () {
    expect(true, isFourOfAKind([9, 5, 9, 9, 9].map(createCard).toList()));
    expect(true, isFourOfAKind([6, 6, 6, 7, 6].map(createCard).toList()));
    expect(true, isFourOfAKind([11, 11, 12, 11, 11].map(createCard).toList()));
    expect(true, isFourOfAKind([1, 13, 13, 13, 13].map(createCard).toList()));
    expect(false, isFourOfAKind([1, 2, 3, 4, 5].map(createCard).toList()));
    expect(false, isFourOfAKind([2, 2, 3, 2, 5].map(createCard).toList()));
    expect(false, isFourOfAKind([12, 2, 3, 2, 2].map(createCard).toList()));
    expect(false, isFourOfAKind([11, 13, 13, 11, 11].map(createCard).toList()));
  });

  test('Test: full house', () {
    expect(true, isFullHouse([9, 5, 9, 5, 9].map(createCard).toList()));
    expect(true, isFullHouse([6, 6, 7, 7, 6].map(createCard).toList()));
    expect(true, isFullHouse([12, 11, 12, 11, 11].map(createCard).toList()));
    expect(true, isFullHouse([1, 13, 13, 13, 1].map(createCard).toList()));
    expect(false, isFullHouse([1, 2, 3, 4, 5].map(createCard).toList()));
    expect(false, isFullHouse([2, 2, 3, 3, 5].map(createCard).toList()));
    expect(false, isFullHouse([12, 10, 13, 10, 10].map(createCard).toList()));
    expect(false, isFullHouse([7, 7, 8, 8, 9].map(createCard).toList()));
  });

  test('Test: three of a kind', () {
    expect(true, isThreeOfAKind([9, 4, 9, 5, 9].map(createCard).toList()));
    expect(true, isThreeOfAKind([3, 7, 7, 7, 6].map(createCard).toList()));
    expect(true, isThreeOfAKind([12, 11, 12, 11, 11].map(createCard).toList()));
    expect(true, isThreeOfAKind([1, 13, 13, 13, 1].map(createCard).toList()));
    expect(false, isThreeOfAKind([1, 2, 3, 4, 5].map(createCard).toList()));
    expect(false, isThreeOfAKind([2, 2, 3, 3, 5].map(createCard).toList()));
    expect(
        false, isThreeOfAKind([12, 10, 13, 10, 12].map(createCard).toList()));
    expect(false, isThreeOfAKind([7, 7, 8, 8, 9].map(createCard).toList()));
  });

  test('Test: two pair', () {
    expect(true, isTwoPair([9, 4, 9, 4, 2].map(createCard).toList()));
    expect(true, isTwoPair([3, 3, 7, 7, 6].map(createCard).toList()));
    expect(true, isTwoPair([12, 13, 12, 11, 11].map(createCard).toList()));
    expect(true, isTwoPair([1, 12, 13, 12, 13].map(createCard).toList()));
    expect(false, isTwoPair([1, 2, 3, 4, 5].map(createCard).toList()));
    expect(false, isTwoPair([2, 2, 13, 12, 3].map(createCard).toList()));
    expect(false, isTwoPair([12, 10, 13, 10, 10].map(createCard).toList()));
    expect(false, isTwoPair([1, 7, 8, 9, 9].map(createCard).toList()));
  });

  test('Test: jack or better', () {
    expect(true, isJackOrBetter([11, 11, 9, 4, 2].map(createCard).toList()));
    expect(true, isJackOrBetter([3, 3, 12, 12, 6].map(createCard).toList()));
    expect(true, isJackOrBetter([2, 13, 2, 3, 13].map(createCard).toList()));
    expect(true, isJackOrBetter([1, 12, 13, 1, 10].map(createCard).toList()));
    expect(false, isJackOrBetter([1, 2, 2, 4, 4].map(createCard).toList()));
    expect(false, isJackOrBetter([2, 2, 13, 12, 3].map(createCard).toList()));
    expect(false, isJackOrBetter([1, 10, 2, 10, 10].map(createCard).toList()));
    expect(false, isJackOrBetter([7, 7, 8, 9, 9].map(createCard).toList()));
  });

  test('Test: straight', () {
    expect(true, isStraight([2, 3, 4, 5, 6].map(createCard).toList()));
    expect(true, isStraight([10, 8, 9, 7, 6].map(createCard).toList()));
    expect(true, isStraight([9, 10, 11, 13, 12].map(createCard).toList()));
    expect(true, isStraight([1, 13, 12, 10, 11].map(createCard).toList()));
    expect(true, isStraight([1, 2, 3, 4, 5].map(createCard).toList()));
    expect(false, isStraight([1, 2, 2, 4, 4].map(createCard).toList()));
    expect(false, isStraight([2, 2, 13, 12, 3].map(createCard).toList()));
    expect(false, isStraight([1, 10, 2, 10, 10].map(createCard).toList()));
    expect(false, isStraight([7, 7, 8, 9, 9].map(createCard).toList()));
  });

  test('Test: flush', () {
    expect(
        true,
        isFlush([
          PlayCard(9, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(10, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(9, suit: 4),
        ]));

    expect(
        false,
        isFlush([
          PlayCard(9, suit: 1),
          PlayCard(5, suit: 4),
          PlayCard(10, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(9, suit: 4),
        ]));

    expect(
        false,
        isFlush([
          PlayCard(9, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(10, suit: 3),
          PlayCard(5, suit: 4),
          PlayCard(9, suit: 4),
        ]));

    expect(
        false,
        isFlush([
          PlayCard(9, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(10, suit: 4),
          PlayCard(5, suit: 4),
          PlayCard(9, suit: 2),
        ]));
  });
}
