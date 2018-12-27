import 'package:flutter/material.dart';
import 'package:video_poker/card.dart';
import 'package:video_poker/global.dart';

class PlayArea extends StatefulWidget {
  @override
  State createState() => PlayAreaState();
}

class PlayAreaState extends State<PlayArea> {
  int _gameState = 0; // 0: ready/result, 1: hold
  String _title = "GAME OVER";
  Deck deck = Deck();
  List<PlayCard> _hand;

  @override
  void initState() {
    _hand = [
      PlayCard.back(),
      PlayCard.back(),
      PlayCard.back(),
      PlayCard.back(),
      PlayCard.back(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Divider(),
        ),
        Expanded(
          flex: 1,
          child: _buildHeader(),
        ),
        Expanded(
          flex: 6,
          child: _buildCardsArea(),
        ),
        Expanded(
          flex: 1,
          child: _buildFooter(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        _title,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            shadows: [
              Shadow(offset: Offset(-2, -2), color: Colors.yellow),
              Shadow(offset: Offset(-2, 2), color: Colors.yellow),
              Shadow(offset: Offset(2, 2), color: Colors.yellow),
              Shadow(offset: Offset(2, -2), color: Colors.yellow),
            ]),
      ),
    );
  }

  Widget _buildCardsArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _hand.map((card) => _buildSingleCard(card)).toList(),
    );
  }

  Widget _buildSingleCard(card) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_gameState == 1) {
            setState(() {
              card.hold = !card.hold;
            });
          }
        },
        child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: <Widget>[
              Text(
                card.hold ? 'HOLD' : ' ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              Image.asset(card.src),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              wager.value++;
              if (wager.value > 5) wager.value = 1;
            },
            child: Container(
              height: 60,
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder(
                valueListenable: wager,
                builder: (context, value, child) {
                  return Text(
                    "BET $value",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: [
                          Shadow(offset: Offset(-1, -1), color: Colors.yellow),
                          Shadow(offset: Offset(-1, 1), color: Colors.yellow),
                          Shadow(offset: Offset(1, 1), color: Colors.yellow),
                          Shadow(offset: Offset(1, -1), color: Colors.yellow),
                        ]),
                  );
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              switch (_gameState) {
                case 0:
                  credits.value -= wager.value;
                  for (int i = 0; i < 5; i++) {
                    _hand[i] = deck.pop();
                  }
                  _title = ' ';
                  _gameState = 1;
                  break;
                case 1:
                  for (int i = 0; i < 5; i++) {
                    if (!_hand[i].hold) {
                      _hand[i] = deck.pop();
                    }
                  }
                  var result = calcPayout(_hand);
                  _title =
                      '${result[0]}${result[1] > 0 ? ' (${result[1]})' : ''}';
                  credits.value += result[1];
                  deck.shuffle();
                  _gameState = 0;
                  break;
              }

              setState(() {});
            },
            child: Container(
              height: 60,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Text(
                "DRAW",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 60,
            alignment: Alignment.centerRight,
            child: ValueListenableBuilder(
              valueListenable: credits,
              builder: (context, value, _) {
                return Text(
                  "CREDITS $value",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [
                        Shadow(offset: Offset(-1, -1), color: Colors.yellow),
                        Shadow(offset: Offset(-1, 1), color: Colors.yellow),
                        Shadow(offset: Offset(1, 1), color: Colors.yellow),
                        Shadow(offset: Offset(1, -1), color: Colors.yellow),
                      ]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
