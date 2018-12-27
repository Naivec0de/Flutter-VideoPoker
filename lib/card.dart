import 'dart:math';

class PlayCard {
  int rank; // 1 to 13, for A to K.
  int suit; // 1 to 4, for four suits.
  bool hold = false;

  PlayCard(this.rank, this.suit);

  factory PlayCard.back() {
    return PlayCard(0, 0);
  }

  String get src {
    if (rank == 0 && suit == 0) {
      return 'assets/back.png';
    }

    String rk = '$rank';
    if (rank == 1) rk = 'a';
    if (rank == 10) rk = 't';
    if (rank == 11) rk = 'j';
    if (rank == 12) rk = 'q';
    if (rank == 13) rk = 'k';
    return 'assets/cards/card$suit$rk.png';
  }
}

class Deck {
  Random rnd = Random();

  // TODO - properly simulate a deck of cards

  PlayCard pop() {
    return PlayCard(
      1 + rnd.nextInt(13),
      1 + rnd.nextInt(4),
    );
  }

  void shuffle() {}
}
