import 'dart:math';

class PlayCard {
  int _rank; // 1 to 13, for A to K.
  int _suit; // 1 to 4, for four suits.

  PlayCard(this._rank, this._suit);

  factory PlayCard.randomCard() {
    Random rnd = Random();

    return PlayCard(
      1 + rnd.nextInt(13),
      1 + rnd.nextInt(4),
    );
  }

  String get src {
    String rank = '$_rank';
    if (_rank == 1) rank = 'a';
    if (_rank == 10) rank = 't';
    if (_rank == 11) rank = 'j';
    if (_rank == 12) rank = 'q';
    if (_rank == 13) rank = 'k';
    return 'assets/cards/card$_suit$rank.png';
  }
}
