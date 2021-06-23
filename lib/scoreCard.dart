import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/scoreBubble.dart';
import 'package:friba_performance_tracker/singleRound.dart';

// This widget forms a score card out the provided list.
//
class ScoreCard extends StatelessWidget {
  final List<Holes> holes;

  ScoreCard({this.holes});

  @override
  Widget build(BuildContext context) {
    final int holeCount = holes.length;

    //print("Holes: ${holes.length}");
    //print(holes[0].throws.length);
    //print(holes[0].holePar);

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black12)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Scorecard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.black12)),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                defaultColumnWidth: FixedColumnWidth(60),
                columnWidths: {
                  0: FixedColumnWidth(80),
                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      children: List.generate(holeCount + 1, (index) {
                        index -= 1;
                        return (Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                (() {
                                  if (index < 0) {
                                    return 'Hole';
                                  }
                                  return '${index + 1}';
                                }()),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ));
                      })),
                  TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: List.generate(holeCount + 1, (index) {
                        index -= 1;
                        return (Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                (() {
                                  if (index < 0) {
                                    return 'Par';
                                  }
                                  return '(${holes[index].holePar})';
                                }()),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )
                            ],
                          ),
                        ));
                      })),
                  TableRow(
                      decoration: BoxDecoration(color: Colors.white),
                      children: List.generate(holeCount + 1, (index) {
                        index -= 1;
                        List<Color> bgColors = [Colors.white, Colors.white];
                        return Container(
                          child: (Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                (() {
                                  if (index < 0) {
                                    return Text(
                                      'Score',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    );
                                  }
                                  int score = holes[index].throws.length -
                                      holes[index].holePar;
                                  if (score > 0) {
                                    bgColors = [
                                      Colors.pink[100],
                                      Colors.pink[50]
                                    ];
                                    return ScoreBubble(
                                      score,
                                      color: bgColors,
                                    );
                                  } else if (score < 0) {
                                    bgColors = [
                                      Colors.lightGreen[100],
                                      Colors.lightGreen[50]
                                    ];
                                    return ScoreBubble(
                                      score,
                                      color: bgColors,
                                    );
                                  }

                                  return ScoreBubble(
                                    score,
                                    color: bgColors,
                                  );
                                }()),
                              ],
                            ),
                          )),
/*                         decoration: BoxDecoration(
                          color: bgColors, shape: BoxShape.circle), */
                        );
                      })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
