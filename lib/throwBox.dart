import 'package:flutter/material.dart';

class ThrowBox extends StatelessWidget {
  final String title;
  final double value;
  final double percent;

  ThrowBox({this.title, this.value, this.percent});
  @override
  Widget build(BuildContext context) {
    print(percent);

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                  (() {
                    if (percent.isNaN) {
                      return 0.toString() + '%';
                    }
                    return percent.toStringAsFixed(1) + '%';
                  }()),
                  style: TextStyle(fontSize: 18)),
              Text('(' + value.toStringAsFixed(0) + ')',
                  style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
