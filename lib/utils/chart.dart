import 'package:biodiv/model/scarcity/scarcity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/analysa model/analysa_model.dart';
import 'colors.dart';

class ShowPieChart extends StatefulWidget {
  final List<int?> itemList;
  const ShowPieChart({super.key, required this.itemList});

  @override
  State<ShowPieChart> createState() => _ShowPieChartState();
}

class _ShowPieChartState extends State<ShowPieChart> {
  int touchedIndex = -1;

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.itemList.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: getColor(i),
        value: widget.itemList[i]!.toDouble(),
        title: widget.itemList[i].toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    });
  }

  Color getColor(int index) {
    final List<Color> colors = [
      AppColor.fiveColor,
      AppColor.secondaryColor,
      AppColor.thirdColor,
      Colors.blueGrey,
      AppColor.colorFour,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: true,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: showingSections(),
      ),
    );
  }
}

class ShowLineChart extends StatelessWidget {
  final List<ScarcityModelChart> data;
  const ShowLineChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      barTouchData: barTouchData,
      titlesData: titlesData,
      borderData: borderData,
      barGroups: data
          .map((dataItem) =>
              BarChartGroupData(x: dataItem.idKelangkaan, barRods: [
                BarChartRodData(
                  toY: dataItem.count.toDouble(),
                  gradient: _barsGradient,
                ),
              ], showingTooltipIndicators: [
                0
              ]))
          .toList(),
      gridData: FlGridData(show: false),
      alignment: BarChartAlignment.spaceAround,
      maxY: 40,
    ));
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColor.mainColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColor.mainColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = 'EX';
        break;
      case 2:
        text = 'EW';
        break;
      case 3:
        text = 'CR';
        break;
      case 4:
        text = 'EN';
        break;
      case 5:
        text = 'VU';
        break;
      case 6:
        text = 'NT';
        break;
      case 7:
        text = 'LC';
        break;
      case 8:
        text = 'DD';
        break;
      case 9:
        text = 'NE';
        break;
      case 10:
        text = 'C';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          AppColor.mainColor,
          AppColor.secondaryColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}

class ChartAnalytic extends StatefulWidget {
  final Map<String, List<AnalysisData>> analyticData; // Nama-nama seri
  const ChartAnalytic({
    Key? key,
    required this.analyticData,
  }) : super(key: key);

  @override
  State<ChartAnalytic> createState() => _ChartAnalyticState();
}

class _ChartAnalyticState extends State<ChartAnalytic> {
  Map<String, List<AnalysisData>>? chartData;
  TrackballBehavior? _trackballBehavior;

  @override
  void initState() {
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    chartData = widget.analyticData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStackedLineChart();
  }

  SfCartesianChart _buildStackedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title:
          ChartTitle(text: 'Occurrence rate', alignment: ChartAlignment.near),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        labelRotation: -30,
      ),
      primaryYAxis: NumericAxis(
          maximum: 30,
          axisLine: const AxisLine(width: 0),
          labelFormat: r'{value}',
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedLineSeries(),
      trackballBehavior: _trackballBehavior,
    );
  }

  List<StackedLineSeries<AnalysisData, String>> _getStackedLineSeries() {
    List<StackedLineSeries<AnalysisData, String>> seriesList = [];

    widget.analyticData.forEach((location, data) {
      seriesList.add(StackedLineSeries<AnalysisData, String>(
        dataSource: data,
        xValueMapper: (AnalysisData data, _) => data.bulan,
        yValueMapper: (AnalysisData data, _) => data.totalPerkemunculan,
        name: location,
        markerSettings: const MarkerSettings(isVisible: true),
      ));
    });
    return seriesList;
  }
}
