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
  // TODO - implement game logic to properly detect winning hands
  Random rnd = Random();
  if (rnd.nextBool()) {
    return ["GAME OVER", 0];
  }

  int index = rnd.nextInt(payout_names.length);
  String name = payout_names[index];
  int value = payout_rate_1x[index] * wager.value;
  if (wager.value == 5) {
    value = payout_rate_5x[index];
  }
  return [name, value];
}