import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ThrowtypesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = [
      new LinearSales('Missed left', 120),
      new LinearSales('Center', 40),
      new LinearSales('Missed right', 80),
    ];

    var series = [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    var pie = new charts.PieChart(series,
        animate: false,
        behaviors: [new charts.DatumLegend()],
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 10,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));

    var pieWidget = new SizedBox(
      height: 250.0,
      child: pie,
    );

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
          Text('Drive Accuracy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [pieWidget],
              )),
        ],
      ),
    );
  }
}

class LinearSales {
  final String year;
  final int sales;

  LinearSales(this.year, this.sales);
}
