import 'package:flutter/material.dart';

// This widget forms a circle shape that has the provided number in the
// center of it. The circle is green if score<0, transparent if score=0 and
// red if number>0
class ScoreBubble extends StatelessWidget {
  final int score;
  final List<Color> color;

  ScoreBubble(this.score, {this.color});

  @override
  Widget build(BuildContext context) {
    bool isBgLight = false;
    return Container(
      height: 40,
      width: 40,
      margin: EdgeInsets.only(left: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: (() {
                if (color == null) {
                  return [Colors.blue[500], Colors.blue[400]];
                }
                isBgLight = true;
                return color;
              }()))),
      child: Center(
        child: Text(
          score < 0
              ? score.toString()
              : score > 0
                  ? '+' + score.toString()
                  : score.toString(),
          softWrap: false,
          style: TextStyle(
              color: isBgLight ? Colors.black : Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
