import 'package:flutter/material.dart';
import 'package:video_poker/global.dart';

class PayoutTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        padding: EdgeInsets.only(left: 1, right: 1, top: 2, bottom: 2),
        child: Row(children: [
          _buildColumn(
              0, payout_names.map((name) => name.toUpperCase()).toList(),
              width: 140, alignment: Alignment.centerLeft),
          _buildColumn(1, payout_rate_1x.map((rate) => '${rate * 1}').toList()),
          _buildColumn(2, payout_rate_1x.map((rate) => '${rate * 2}').toList()),
          _buildColumn(3, payout_rate_1x.map((rate) => '${rate * 3}').toList()),
          _buildColumn(4, payout_rate_1x.map((rate) => '${rate * 4}').toList()),
          _buildColumn(5, payout_rate_5x.map((rate) => '$rate').toList()),
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
