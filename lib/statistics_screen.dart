import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'custom_appbar.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({Key key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  List<charts.Series<Day, String>> _seriesData;

  var data1 = [
    new Day(1, 'Pon', 5),
    new Day(2, 'Wt', 3),
    new Day(3, 'Śr', 2),
    new Day(4, 'Czw', 6),
    new Day(5, 'Pt', 10),
  ];

  @override
  void initState() {
    super.initState();
    _seriesData = [];
    _seriesData.add(
      charts.Series(
        domainFn: (Day day, _) => day.name,
        measureFn: (Day day, _) => day.amount,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Day day, _) =>
            charts.ColorUtil.fromDartColor(Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar('Statistics'),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          children: [
            SizedBox(height: 5),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).accentColor,
                child: Wrap(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(width: 5),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Chart',
                                          style: TextStyle(
                                            color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        child: charts.BarChart(
                                          _seriesData,
                                          animate: true,
                                          domainAxis: charts.OrdinalAxisSpec(
                                            renderSpec: charts.SmallTickRendererSpec(
                                              labelStyle: charts.TextStyleSpec(color: charts.Color.white)
                                            )
                                          ),
                                          primaryMeasureAxis: charts.NumericAxisSpec(
                                            renderSpec: charts.GridlineRendererSpec(
                                              labelStyle: charts.TextStyleSpec(color: charts.Color.white)
                                            )
                                          ),
                                          //behaviors: [new charts.SeriesLegend()],
                                          animationDuration:
                                              Duration(seconds: 3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                      ])
                ])),
          ],
        ));
  }
}

class Day {
  String name;
  int amount;
  int id;

  Day(this.id, this.name, this.amount);
}
