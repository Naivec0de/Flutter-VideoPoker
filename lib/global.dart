import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:video_poker/card.dart';

const payout_names = [
/* 0 */ "Royal Flush",
/* 1 */ "Straight Flush",
/* 2 */ "Four of a Kind",
/* 3 */ "Full House",
/* 4 */ "Flush",
/* 5 */ "Straight",
/* 6 */ "Three of a Kind",
/* 7 */ "Two Pair",
/* 8 */ "Jacks or Better",
];
const payout_rate_1x = [250, 50, 25, 9, 6, 4, 3, 2, 1];
const payout_rate_5x = [4000, 250, 125, 45, 30, 20, 15, 10, 5];

ValueNotifier<int> wager = ValueNotifier(2); // current wager
ValueNotifier<int> credits = ValueNotifier(200); // total credits

List calcPayout(List<PlayCard> hand) {
  int type = getPayoutType(hand);
  if (type == -1) {
    return ["GAME OVER", 0];
  }
  String name = payout_names[type];
  int value = payout_rate_1x[type] * wager.value;
  if (wager.value == 5) {
    value = payout_rate_5x[type];
  }
  return [name, value];
}

int getPayoutType(List<PlayCard> hand) {
  bool straight = isStraight(hand);
  bool flush = isFlush(hand);
  if (straight) {
    if (flush) {
      if (getSortedString(hand) == 'ajkqt') {
        return 0;
      }
      return 1;
    }
  }
  if (isFourOfAKind(hand)) return 2;
  if (isFullHouse(hand)) return 3;
  if (isFlush(hand)) return 4;
  if (straight) return 5;
  if (isThreeOfAKind(hand)) return 6;
  if (isTwoPair(hand)) return 7;
  if (isJackOrBetter(hand)) return 8;
  return -1;
}

String getSortedString(List<PlayCard> hand) {
  List<String> str = hand.map((card) => card.letterRank).toList();
  str.sort();
  return str.join();
}

bool isFourOfAKind(hand) => RegExp("(.)\\1{3}").hasMatch(getSortedString(hand));

bool isFullHouse(hand) =>
    RegExp("(.)\\1{2}(.)\\2").hasMatch(getSortedString(hand)) ||
    RegExp("(.)\\1(.)\\2{2}").hasMatch(getSortedString(hand));

bool isThreeOfAKind(hand) =>
    RegExp("(.)\\1{2}").hasMatch(getSortedString(hand));

bool isTwoPair(hand) =>
    RegExp("(.)\\1.?(.)\\2").hasMatch(getSortedString(hand));

bool isJackOrBetter(hand) =>
    RegExp("([jqka])\\1").hasMatch(getSortedString(hand));

bool isStraight(List<PlayCard> hand) {
  List<int> list = hand.map((card) => card.rank).toList();
  list.sort();
  if (list.contains(1) && list.contains(13)) {
    list.remove(1);
    list.add(14);
  }
  for (int i = 1; i < 5; i++) {
    if (list[i] != list[i - 1] + 1) {
      return false;
    }
  }
  return true;
}

bool isFlush(List<PlayCard> hand) {
  for (int i = 1; i < 5; i++) {
    if (hand[i].suit != hand[0].suit) {
      return false;
    }
  }
  return true;
}
