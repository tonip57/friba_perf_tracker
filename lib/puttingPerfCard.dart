import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:friba_performance_tracker/singleRound.dart';

// This widget builds a bar diagram out of the provided putt list.
// Uses the charts_flutter library provided by Google.
// https://pub.dev/packages/charts_flutter
//
class PuttingPerfCard extends StatelessWidget {
  final List<Putts> putts;

  PuttingPerfCard({this.putts});

  @override
  Widget build(BuildContext context) {
    List<PuttingSuccess> data = [];
    List<PuttingFail> failData = [];
    int puttsMade = 0;
    int puttsMissed = 0;

    if (putts != null) {
      for (var i = 0; i < putts.length; i++) {
        data.add(
            new PuttingSuccess(putts[i].ring, putts[i].made, Colors.blue[500]));
      }

      for (var i = 0; i < putts.length; i++) {
        failData.add(
            new PuttingFail(putts[i].ring, putts[i].missed, Colors.pink[200]));
      }

      for (var i = 0; i < putts.length; i++) {
        puttsMade += putts[i].made;
        puttsMissed += putts[i].missed;
      }
    }

    var series = [
      new charts.Series(
          id: 'Made',
          domainFn: (PuttingSuccess clickData, _) => clickData.distance,
          measureFn: (PuttingSuccess clickData, _) => clickData.putts,
          colorFn: (PuttingSuccess clickData, _) => clickData.color,
          data: data,
          labelAccessorFn: (PuttingSuccess puttData, _) =>
              '${puttData.putts.toString()}'),
      new charts.Series(
          id: 'Missed',
          domainFn: (PuttingFail clickData, _) => clickData.distance,
          measureFn: (PuttingFail clickData, _) => clickData.putts,
          colorFn: (PuttingFail clickData, _) => clickData.color,
          data: failData,
          labelAccessorFn: (PuttingFail puttData, _) =>
              '${puttData.putts.toString()}'),
    ];

    var chart = new charts.BarChart(
      series,
      animate: false,
      vertical: false,
      barGroupingType: charts.BarGroupingType.grouped,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      behaviors: [
        new charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
            outsideJustification: charts.OutsideJustification.middle)
      ],
    );

    var chartWidget = new SizedBox(
      height: 300.0,
      child: chart,
    );

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
          Text('Putting Performance',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Putts made: ' + puttsMade.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    )),
                Text('Putts missed: ' + puttsMissed.toString(),
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [chartWidget],
              )),
        ],
      ),
    );
  }
}

class PuttingSuccess {
  final String distance;
  final int putts;
  final charts.Color color;

  PuttingSuccess(this.distance, this.putts, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class PuttingFail {
  final String distance;
  final int putts;
  final charts.Color color;

  PuttingFail(this.distance, this.putts, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
