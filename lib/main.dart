import 'package:flutter/material.dart';

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

class PayoutTable extends StatefulWidget {
  @override
  State createState() => PayoutTableState();
}

class PayoutTableState extends State<PayoutTable> {
  int _highlight = 1;

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

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: FittedBox(
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
      ),
    );
  }

  Widget _buildColumn(int id, List<String> content,
      {double width = 40, alignment = Alignment.centerRight}) {
    return GestureDetector(
      onTap: () {
        if (id != 0) {
          setState(() {
            _highlight = id;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Column(
          children: content.map((text) {
            return Container(
              alignment: alignment,
              color: id == _highlight ? Colors.red : Colors.grey,
              height: 20,
              width: width,
              margin: EdgeInsets.only(left: 1, right: 1),
              child: Text(
                text,
                style: TextStyle(color: Colors.yellow),
              ),
            );
          }).toList(),
        ),
      ),
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
              child: Text("Play Area"),
            ),
            Expanded(
              flex: 1,
              child: Text("Buttons"),
            )
          ],
        ),
      ),
    );
  }
}
