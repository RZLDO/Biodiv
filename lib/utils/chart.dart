import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    final List<String> _taksonomiItems = [
      'class',
      'ordo',
      'famili',
      'genus',
      'spesies'
    ];

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
    // Assign different colors based on index or any other condition
    // Here's an example using a list of predefined colors
    final List<Color> colors = [
      AppColor.mainColor,
      AppColor.secondaryColor,
      AppColor.thirdColor,
      Colors.blueGrey,
      Colors.blue,
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
