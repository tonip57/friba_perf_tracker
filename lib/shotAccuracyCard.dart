import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ShotAccuracyCard extends StatelessWidget {
  final String title;
  final int leftIndicatorValue;
  final int centerIndicatorValue;
  final int rightIndicatorValue;

  ShotAccuracyCard(
      {@required this.title,
      @required this.leftIndicatorValue,
      @required this.centerIndicatorValue,
      @required this.rightIndicatorValue});
  @override
  Widget build(BuildContext context) {
    int valuesCombined =
        leftIndicatorValue + centerIndicatorValue + rightIndicatorValue;

    double leftDouble = leftIndicatorValue / valuesCombined;
    double centerDouble = centerIndicatorValue / valuesCombined;
    double rightDouble = rightIndicatorValue / valuesCombined;

    print(valuesCombined);
    print(leftDouble);
    print(centerDouble);
    print(rightDouble);

    double test = leftDouble + centerDouble + rightDouble;

    print('test:' + test.toString());

    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
      ),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black12)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(title ?? 'Default Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Text(
              'How your throws landed compared to your target point on the ground',
              style: TextStyle(fontSize: 15, color: Colors.black54)),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularPercentIndicator(
                        radius: 100,
                        lineWidth: 10,
                        percent: leftDouble,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Color(0x0F000000),
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (leftDouble * 100).toStringAsFixed(1) + '%',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Left Miss',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        progressColor: Colors.pink[200],
                      ),
                      CircularPercentIndicator(
                        radius: 120,
                        lineWidth: 10,
                        percent: centerDouble,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Color(0x0F000000),
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (centerDouble * 100).toStringAsFixed(1) + '%',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Center',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        progressColor: Colors.blue[500],
                      ),
                      CircularPercentIndicator(
                        radius: 100,
                        lineWidth: 10,
                        percent: rightDouble,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Color(0x0F000000),
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              (rightDouble * 100).toStringAsFixed(1) + '%',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Right Miss',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.normal),
                            )
                          ],
                        ),
                        progressColor: Colors.pink[200],
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
