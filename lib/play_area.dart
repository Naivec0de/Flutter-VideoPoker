import 'package:flutter/material.dart';
import 'package:video_poker/card.dart';
import 'package:video_poker/global.dart';

class PlayArea extends StatefulWidget {
  @override
  State createState() => PlayAreaState();
}

class PlayAreaState extends State<PlayArea> {
  String _header = "THREE OF A KIND";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(),
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
        _header,
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
      children: <Widget>[
        _buildSingleCard(PlayCard.randomCard()),
        _buildSingleCard(PlayCard.randomCard()),
        _buildSingleCard(PlayCard.randomCard()),
        _buildSingleCard(PlayCard.randomCard()),
        _buildSingleCard(PlayCard.randomCard()),
      ],
    );
  }

  Widget _buildSingleCard(card) {
    return Expanded(
      child: FittedBox(
        fit: BoxFit.fill,
        child: Column(
          children: <Widget>[
            Text(
              "HOLD",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Image.asset(card.src),
          ],
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
                    "BET ${wager.value}",
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
        Expanded(
          child: Container(
            height: 60,
            alignment: Alignment.centerRight,
            child: Text(
              "CREDITS 433",
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
            ),
          ),
        ),
      ],
    );
  }
}
