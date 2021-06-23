import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/singleRound.dart';
import 'package:friba_performance_tracker/throwBox.dart';

class ThrowsCard extends StatelessWidget {
  final List<Holes> holes;

  ThrowsCard(this.holes);

  @override
  Widget build(BuildContext context) {
    double longLeft = 0;
    double longCenter = 0;
    double longRight = 0;
    double centerLeft = 0;
    double perfect = 0;
    double centerRight = 0;
    double shortLeft = 0;
    double shortCenter = 0;
    double shortRight = 0;
    int uniqueTypes = 1;

    for (var i = 0; i < holes.length; i++) {
      for (var j = 0; j < holes[i].throws.length; j++) {
        print(holes[i].throws[j].evaluation);
        String evaluation = holes[i].throws[j].evaluation;

        if (evaluation == 'LongLeft') {
          longLeft += 1;
        }

        if (evaluation == 'LongCenter') {
          longCenter += 1;
        }

        if (evaluation == 'LongRight') {
          longRight += 1;
        }

        if (evaluation == 'CenterLeft') {
          centerLeft += 1;
        }

        if (evaluation == 'Perfect') {
          perfect += 1;
        }

        if (evaluation == 'CenterRight') {
          centerRight += 1;
        }

        if (evaluation == 'ShortLeft') {
          shortLeft += 1;
        }

        if (evaluation == 'ShortCenter') {
          shortCenter += 1;
        }

        if (evaluation == 'ShortRight') {
          shortRight += 1;
        }
      }
    }

    if (longLeft > 0) {
      uniqueTypes += 1;
    }
    if (longCenter > 0) {
      uniqueTypes += 1;
    }
    if (longRight > 0) {
      uniqueTypes += 1;
    }
    if (centerLeft > 0) {
      uniqueTypes += 1;
    }
    if (perfect > 0) {
      uniqueTypes += 1;
    }
    if (centerRight > 0) {
      uniqueTypes += 1;
    }
    if (shortLeft > 0) {
      uniqueTypes += 1;
    }
    if (shortCenter > 0) {
      uniqueTypes += 1;
    }
    if (shortRight > 0) {
      uniqueTypes += 1;
    }

    double throwCount = longLeft +
        longCenter +
        longRight +
        centerLeft +
        perfect +
        centerRight +
        shortLeft +
        shortCenter +
        shortRight;

    return Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black12)),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Throws',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      ThrowBox(
                        title: 'LongLeft',
                        value: longLeft,
                        percent: (longLeft / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'LongCenter',
                        value: longCenter,
                        percent: (longCenter / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'LongRight',
                        value: longRight,
                        percent: (longRight / throwCount) * 100,
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      ThrowBox(
                        title: 'CenterLeft',
                        value: centerLeft,
                        percent: (centerLeft / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'Perfect',
                        value: perfect,
                        percent: (perfect / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'CenterRight',
                        value: centerRight,
                        percent: (centerRight / throwCount) * 100,
                      ),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      ThrowBox(
                        title: 'ShortLeft',
                        value: shortLeft,
                        percent: (shortLeft / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'ShortCenter',
                        value: shortCenter,
                        percent: (shortCenter / throwCount) * 100,
                      ),
                      ThrowBox(
                        title: 'ShortRight',
                        value: shortRight,
                        percent: (shortRight / throwCount) * 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
