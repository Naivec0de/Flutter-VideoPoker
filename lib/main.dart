import 'package:flutter/material.dart';
import 'package:video_poker/card.dart';
import 'package:video_poker/global.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Poker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class PayoutTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const names = [
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
    const basePayRate = [250, 50, 25, 9, 6, 4, 3, 2, 1];
    const specialRate = [4000, 250, 125, 45, 30, 20, 15, 10, 5];

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        padding: EdgeInsets.only(left: 1, right: 1, top: 2, bottom: 2),
        child: Row(children: [
          _buildColumn(0, names.map((name) => name.toUpperCase()).toList(),
              width: 140, alignment: Alignment.centerLeft),
          _buildColumn(1, basePayRate.map((rate) => '${rate * 1}').toList()),
          _buildColumn(2, basePayRate.map((rate) => '${rate * 2}').toList()),
          _buildColumn(3, basePayRate.map((rate) => '${rate * 3}').toList()),
          _buildColumn(4, basePayRate.map((rate) => '${rate * 4}').toList()),
          _buildColumn(5, specialRate.map((rate) => '${rate * 1}').toList()),
        ]),
      ),
    );
  }

  Widget _buildColumn(int id, List<String> content,
      {double width = 40, alignment = Alignment.centerRight}) {
    return GestureDetector(
      onTap: () {
        if (id != 0) {
          wager.value = id;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: wager,
        child: Column(
          children: content.map((text) {
            return Container(
              alignment: alignment,
              height: 20,
              width: width,
              child: Text(
                text,
                style: TextStyle(color: Colors.yellow),
              ),
            );
          }).toList(),
        ),
        builder: (context, value, child) {
          return Container(
            decoration: BoxDecoration(
              color: id == wager.value ? Colors.red : Colors.grey,
              border: Border.all(color: Colors.yellow),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Video Poker"),
      ),
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: PayoutTable(),
              ),
              Expanded(
                flex: 3,
                child: PlayArea(),
              ),
              Expanded(
                flex: 2,
                child: Text("Odds"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
