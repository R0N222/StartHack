import 'package:flutter/material.dart';
import 'package:starthack/Stock/Chart.dart';
import 'package:starthack/routes.dart';

import 'package:starthack/Stock/Stockpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
    );
  }
}

class SmallChartWidget extends StatelessWidget {
  const SmallChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: PageView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: const Color(0xff020227),
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: 
                  SmallLineChartWidget()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
