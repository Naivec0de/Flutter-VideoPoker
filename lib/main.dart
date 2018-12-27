import 'package:flutter/material.dart';
import 'package:video_poker/payout_table.dart';
import 'package:video_poker/play_area.dart';

void main() => runApp(VideoPoker());

class VideoPoker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Poker',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: GameScaffold(),
    );
  }
}

class GameScaffold extends StatelessWidget {
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
