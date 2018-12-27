import 'dart:math';

class PlayCard {
  int rank; // 1 to 13, for A to K.
  String get letterRank {
    String letter = '$rank';
    if (rank == 1) letter = 'a';
    if (rank == 10) letter = 't';
    if (rank == 11) letter = 'j';
    if (rank == 12) letter = 'q';
    if (rank == 13) letter = 'k';
    return letter;
  }

  int suit; // 1 to 4, for four suits.
  bool hold = false;

  PlayCard(this.rank, {this.suit = 1});

  factory PlayCard.back() {
    return PlayCard(0, suit: 0);
  }

  String get src {
    if (rank == 0 && suit == 0) {
      return 'assets/back.png';
    }
    return 'assets/cards/card$suit$letterRank.png';
  }
}

class Deck {
  Random rnd = Random();

  // TODO - properly simulate a deck of cards

  PlayCard pop() {
    return PlayCard(
      1 + rnd.nextInt(13),
      suit: 1 + rnd.nextInt(4),
    );
  }

  void shuffle() {}
}
