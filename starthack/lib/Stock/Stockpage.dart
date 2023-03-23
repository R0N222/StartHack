import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:starthack/Stock/Chart.dart';

class BigLineChart extends StatelessWidget {
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
          
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))),
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

class StockScreenWidget extends StatelessWidget {
  const StockScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('asd'),),
      body: Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: PageView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: Color.fromARGB(255, 153, 160, 55),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 30),
                child: 
                  BigLineChart(),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
  
}


