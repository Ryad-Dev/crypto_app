import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class CryptoGraph extends StatelessWidget {
  //final List<charts.Series> seriesList;
   final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;

  CryptoGraph(this.seriesList, {this.animate = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Graphique des prix')),
      body: charts.TimeSeriesChart(
        seriesList,
        animate: animate,
      ),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createSampleData() {
    final data = [
      TimeSeriesSales(DateTime(2023, 1, 1), 5),
      TimeSeriesSales(DateTime(2023, 2, 1), 25),
      TimeSeriesSales(DateTime(2023, 3, 1), 100),
      TimeSeriesSales(DateTime(2023, 4, 1), 75),
    ];

    return [
      charts.Series<TimeSeriesSales, DateTime>(
        id: 'CryptoPrice',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
