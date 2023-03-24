import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SmallLineChartWidget extends StatelessWidget {
  final List<FlSpot> values;
  final List<Color> gradientColors = [
    const Color(0xff0E0741),
    const Color(0xff8236FD),
  ];

  final List<Color> gradientColors2 = [
    const Color(0xff8236FD),
    Color.fromARGB(255, 240, 240, 244),
  ];

  SmallLineChartWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    double minx = 10000000;
    double maxx = 0;
    double miny = 10000000;
    double maxy = 0;
    print("Values " + "${values.length}");
    for (int i = 0; i < values.length; i++) {
      if (minx > values[i].x) minx = values[i].x;
      if (miny > values[i].y) miny = values[i].y;
      if (maxx < values[i].x) maxx = values[i].x;
      if (maxy < values[i].y) maxy = values[i].y;
    }

    return LineChart(
      LineChartData(
          minX: minx,
          maxX: maxx,
          minY: miny,
          maxY: maxy,
          borderData: FlBorderData(border: Border(bottom: BorderSide.none)),
          titlesData: FlTitlesData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
                spots: values,
                isCurved: true,
                gradient: LinearGradient(colors: gradientColors),
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: true, gradient: LinearGradient(colors: gradientColors2.map((color) => color.withOpacity(0.3)).toList(), begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          ],
          gridData: FlGridData(drawHorizontalLine: false, drawVerticalLine: false)),
    );
  }
}
