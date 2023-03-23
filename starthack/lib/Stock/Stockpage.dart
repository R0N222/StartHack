import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:starthack/Stock/Chart.dart';

class StockScreenWidget extends StatelessWidget {
  const StockScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chart')),
      body: LineChartWidget()
    );
  }
}


