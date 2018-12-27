import 'package:flutter/foundation.dart';

const payout_names = [
  "Royal Flush",
  "Straight Flush",
  "Four of a Kind",
  "Full House",
  "Flush",
  "Straight",
  "Three of a Kind",
  "Two Pair",
  "Jacks or Better",
];
const payout_rate_1x = [250, 50, 25, 9, 6, 4, 3, 2, 1];
const payout_rate_5x = [4000, 250, 125, 45, 30, 20, 15, 10, 5];

ValueNotifier<int> wager = ValueNotifier(2); // current wager
ValueNotifier<int> credits = ValueNotifier(200); // total credits
