import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MyGraphWidget extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;
  final double width;
  final double height;

  MyGraphWidget({
    required this.seriesList,
    required this.animate,
    this.width = 300,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: charts.LineChart(
        seriesList,
        animate: animate,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
        ),
        domainAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 5,
          ),
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 3,
          ),
        ),
        behaviors: [
          charts.SeriesLegend(),
          charts.SlidingViewport(),
          charts.PanAndZoomBehavior(),
        ],
      ),
    );
  }
}
