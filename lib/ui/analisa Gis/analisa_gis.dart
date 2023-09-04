import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalisaGIS extends StatefulWidget {
  final int idSpesies;
  const AnalisaGIS({super.key, required this.idSpesies});

  @override
  State<AnalisaGIS> createState() => _AnalisaGISState();
}

class _AnalisaGISState extends State<AnalisaGIS> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: "Occurrence Rate"),
          // Enable legend

          // Enable tooltip
          tooltipBehavior: _tooltipBehavior,
          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData(month: 'Jan', date: 35),
                  SalesData(month: 'Feb', date: 45),
                  SalesData(month: 'March', date: 35),
                  SalesData(month: 'Jsdad', date: 35),
                  SalesData(month: 'asfa', date: 45),
                  SalesData(month: 'Masa', date: 35),
                  SalesData(month: 'Jasd', date: 35),
                  SalesData(month: 'af', date: 45),
                  SalesData(month: 'asd', date: 35),
                ],
                xValueMapper: (SalesData sales, _) => sales.month,
                yValueMapper: (SalesData sales, _) => sales.date,
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ]),
    )));
  }
}

class SalesData {
  String month;
  int date;

  SalesData({
    required this.date,
    required this.month,
  });
}
