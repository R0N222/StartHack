import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SmallLineChartWidget extends StatelessWidget {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) => LineChart(
        LineChartData(
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          borderData: FlBorderData(border: Border(bottom: BorderSide.none)),
          titlesData: FlTitlesData(
            show: false,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 2.5),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              gradient: LinearGradient(colors: gradientColors),
              barWidth: 5,
              dotData: FlDotData(show: false)
            ),
          ],
          gridData: FlGridData(drawHorizontalLine: false, drawVerticalLine: false )
        ),
        
      );
}